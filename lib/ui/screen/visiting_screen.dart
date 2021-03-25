import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/bottom_navigation_view.dart';
import 'package:places/ui/screen/sight_card.dart';

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
                  icon: Icon(Icons.calendar_today),
                  onPressed: () {},
                  color: theme.accentIconTheme.color,
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {},
                  color: theme.accentIconTheme.color,
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
                  icon: Icon(Icons.share),
                  onPressed: () {},
                  color: theme.accentIconTheme.color,
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {},
                  color: theme.accentIconTheme.color,
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
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: isSelected(i)
                      ? theme.labelColor
                      : theme.unselectedLabelColor,
                ),
                child: Center(
                  child: Text(
                    widget.labels[i],
                    style: isSelected(i)
                        ? theme.labelStyle
                        : theme.unselectedLabelStyle,
                  ),
                ),
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
