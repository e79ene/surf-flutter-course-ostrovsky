import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/bottom_navigation_view.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/svg_icon.dart';

class VisitingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Избранное'),
          bottom: _TabBar(labels: ['Хочу посетить', 'Посетил']),
        ),
        body: TabBarView(children: [
          _VisitingList(
            sights: mocks
                .asMap()
                .entries
                .where((e) => e.key % 2 == 1)
                .map((e) => e.value),
            makeSightView: (sight) => SightCard(
              sight,
              actions: [
                IconButton(
                  icon: SvgIcon('res/figma/Icons/Icon/Calendar.svg'),
                  onPressed: () {},
                ),
                IconButton(
                  icon: SvgIcon('res/figma/Icons/Icon/Close.svg'),
                  onPressed: () {},
                ),
              ],
              afterTitle: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      'Запланировано на 12 окт. 2020',
                      style: TextStyle(color: theme.accentColor),
                    ),
                  ),
                  Text(
                    'закрыто до 09:00',
                    style: TextStyle(color: theme.disabledColor),
                  ),
                ],
              ),
              onTap: () => print('Card planned'),
            ),
          ),
          _VisitingList(
            sights: mocks
                .asMap()
                .entries
                .where((e) => e.key % 2 == 0)
                .map((e) => e.value),
            makeSightView: (sight) => SightCard(
              sight,
              actions: [
                IconButton(
                  icon: SvgIcon('res/figma/Icons/Icon/Share.svg'),
                  onPressed: () {},
                ),
                IconButton(
                  icon: SvgIcon('res/figma/Icons/Icon/Close.svg'),
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
                      style: TextStyle(color: theme.disabledColor),
                    ),
                  ),
                  Text(
                    'закрыто до 09:00',
                    style: TextStyle(color: theme.disabledColor),
                  ),
                ],
              ),
              onTap: () => print('Card visited'),
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
  Size get preferredSize => Size.fromHeight(40);

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
    final theme = Theme.of(context).tabBarTheme;

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
                  elevation: 0,
                  primary: isSelected(i)
                      ? theme.labelColor
                      : theme.unselectedLabelColor,
                  onPrimary: isSelected(i)
                      ? theme.labelStyle!.color
                      : theme.unselectedLabelStyle!.color,
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
