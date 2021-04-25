import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/bottom_navigation_view.dart';
import 'package:places/ui/res/my_icons.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/widget/sight_card.dart';
import 'package:places/ui/screen/widget/my_app_bar.dart';
import 'package:places/ui/svg_icon.dart';

class VisitingScreen extends StatefulWidget {
  @override
  _VisitingScreenState createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: MyAppBar(
          title: 'Избранное',
          bottom: _TabBar(labels: ['Хочу посетить', 'Посетил']),
        ),
        body: TabBarView(children: [
          _VisitingList(
            sights: placeInteractor.getFavorite(),
            makeSightView: (place) => SightCard(
              place,
              key: ObjectKey(place),
              actions: [
                IconButton(
                  icon: SvgIcon(MyIcons.Calendar),
                  onPressed: _setTime,
                ),
                IconButton(
                  icon: SvgIcon(MyIcons.Close),
                  onPressed: () =>
                      setState(() => placeInteractor.removeFromFavorite(place)),
                ),
              ],
              afterTitle: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      'Запланировано на 12 окт. 2020',
                      style: TextStyle(color: theme.color.green),
                    ),
                  ),
                  Text(
                    'закрыто до 09:00',
                    style: TextStyle(color: theme.color.secondary2),
                  ),
                ],
              ),
            ),
          ),
          _VisitingList(
            sights: placeInteractor.getVisited(),
            makeSightView: (place) => SightCard(
              place,
              key: ObjectKey(place),
              actions: [
                IconButton(
                  icon: SvgIcon(MyIcons.Share),
                  onPressed: () {},
                ),
              ],
              afterTitle: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      'Цель достигнута 12 окт. 2020',
                      style: TextStyle(color: theme.color.secondary2),
                    ),
                  ),
                  Text(
                    'закрыто до 09:00',
                    style: TextStyle(color: theme.color.secondary2),
                  ),
                ],
              ),
            ),
          ),
        ]),
        bottomNavigationBar: BottomNavigationView.visiting(),
      ),
    );
  }

  void _setTime() async {
    final time = await showAdaptiveTimePicker(context);

    if (time != null) throw UnimplementedError('Selected time: $time');
  }
}

Future<TimeOfDay?> showAdaptiveTimePicker(BuildContext context) async {
  return await (Platform.isIOS
      ? showIosTimePicker(context)
      : showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        ));
}

Future<TimeOfDay?> showIosTimePicker(BuildContext context) async {
  final theme = Theme.of(context);

  return await showCupertinoModalPopup<TimeOfDay>(
    context: context,
    builder: (context) => Container(
      height: 240,
      color: theme.color.background,
      child: CupertinoDatePicker(
        onDateTimeChanged: (dateTime) => print('dateTime: $dateTime'),
        // Navigator.maybePop(context, TimeOfDay.fromDateTime(dateTime)),
        mode: CupertinoDatePickerMode.time,
        initialDateTime: DateTime.now(),
      ),
    ),
  );
}

class _TabBar extends StatefulWidget implements PreferredSizeWidget {
  static const double tabBarHeight = 52;
  final List<String> labels;

  const _TabBar({Key? key, required this.labels}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(tabBarHeight);

  @override
  _TabBarState createState() => _TabBarState();
}

class _TabBarState extends State<_TabBar> {
  // By default theme buttons have at least kMinInteractiveDimension height
  static const double vPadding =
      (_TabBar.tabBarHeight - kMinInteractiveDimension) / 2;

  TabController? _controller;

  TabController get controller {
    if (_controller == null) {
      _controller = DefaultTabController.of(context);
      assert(_controller != null, 'Must have DefaultTabController ancestor');

      _controller!.addListener(() => setState(() {}));
    }

    return _controller!;
  }

  bool isSelected(int i) => controller.index == i;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: vPadding, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < widget.labels.length; i++)
            Expanded(
              child: ElevatedButton(
                child: Text(widget.labels[i]),
                style: ElevatedButton.styleFrom(
                  primary:
                      isSelected(i) ? theme.color.foreground : theme.color.card,
                  onPrimary: isSelected(i)
                      ? theme.color.background
                      : theme.color.secondary2,
                  minimumSize: Size.fromHeight(40), // - visible height
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  textStyle: TextStyle(),
                ),
                onPressed: () => controller.index = i,
              ),
            ),
        ],
      ),
    );
  }
}

class _VisitingList extends StatefulWidget {
  final List<Place> sights;
  final Widget Function(Place) makeSightView;

  _VisitingList({
    required this.sights,
    required this.makeSightView,
  });

  @override
  _VisitingListState createState() => _VisitingListState();
}

class _VisitingListState extends State<_VisitingList> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: widget.sights.length,
        itemBuilder: (context, index) {
          final sight = widget.sights[index];
          final card = widget.makeSightView(sight);

          return DragTarget<Place>(
            onAccept: _acceptDrag(sight),
            builder: (context, candidateData, rejectedData) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: LongPressDraggable<Place>(
                axis: Axis.vertical,
                data: sight,
                child: Dismissible(
                  key: ValueKey(sight),
                  child: card,
                  direction: DismissDirection.endToStart,
                  background: buildDismissBackground(theme),
                  onDismissed: (direction) =>
                      setState(() => widget.sights.remove(sight)),
                ),
                childWhenDragging: const SizedBox.shrink(),
                feedback: Material(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 32,
                    child: card,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildDismissBackground(ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(16),
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        color: theme.color.red,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgIcon(
            'res/figma/Icons/Icon/Bucket.svg',
            color: theme.color.white,
          ),
          Text(
            'Удалить',
            style: theme.text.superSmall.copyWith(
              fontWeight: FontWeight.w500,
              color: theme.color.white,
            ),
          ),
        ],
      ),
    );
  }

  _acceptDrag(Place sight) => (draggedSight) => setState(() {
        if (sight == draggedSight) return;

        widget.sights
          ..remove(draggedSight)
          ..insert(widget.sights.indexOf(sight), draggedSight);
      });
}
