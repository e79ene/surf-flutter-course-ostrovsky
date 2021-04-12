import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/domain/sight_repo.dart';
import 'package:places/ui/bottom_navigation_view.dart';
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
            sights: sightRepo.planned,
            makeSightView: (sight) => SightCard(
              sight,
              key: ObjectKey(sight),
              actions: [
                IconButton(
                  icon: SvgIcon('res/figma/Icons/Icon/Calendar.svg'),
                  onPressed: () {},
                ),
                IconButton(
                  icon: SvgIcon('res/figma/Icons/Icon/Close.svg'),
                  onPressed: () =>
                      setState(() => sightRepo.planned.remove(sight)),
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
            sights: sightRepo.visited,
            makeSightView: (sight) => SightCard(
              sight,
              key: ObjectKey(sight),
              actions: [
                IconButton(
                  icon: SvgIcon('res/figma/Icons/Icon/Share.svg'),
                  onPressed: () {},
                ),
                IconButton(
                  icon: SvgIcon('res/figma/Icons/Icon/Close.svg'),
                  onPressed: () =>
                      setState(() => sightRepo.visited.remove(sight)),
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
        bottomNavigationBar: BottomNavigationView(),
      ),
    );
  }
}

class _TabBar extends StatefulWidget implements PreferredSizeWidget {
  final List<String> labels;

  const _TabBar({Key? key, required this.labels}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(52);

  @override
  _TabBarState createState() => _TabBarState();
}

class _TabBarState extends State<_TabBar> {
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
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
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
                  minimumSize: Size.fromHeight(40),
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

class _VisitingList extends StatelessWidget {
  final Iterable<Sight> sights;
  final Widget Function(Sight) makeSightView;

  _VisitingList({
    required this.sights,
    required this.makeSightView,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            for (var sight in sights)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: makeSightView(sight),
              )
          ],
        ),
      ),
    );
  }
}
