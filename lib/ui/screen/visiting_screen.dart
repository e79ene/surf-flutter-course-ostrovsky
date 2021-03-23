import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/global_theme.dart';
import 'package:places/ui/screen/sight_card.dart';

class VisitingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Избранное'),
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
                  color: onImageElementColor,
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {},
                  color: onImageElementColor,
                ),
              ],
              afterTitle: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      'Запланировано на 12 окт. 2020',
                      style: plannedForStyle,
                    ),
                  ),
                  Text(
                    'закрыто до 09:00',
                    style: closedTillStyle,
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
                  color: onImageElementColor,
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {},
                  color: onImageElementColor,
                ),
              ],
              afterTitle: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      'Цель достигнута 12 окт. 2020',
                      style: goalAchievedStyle,
                    ),
                  ),
                  Text(
                    'закрыто до 09:00',
                    style: closedTillStyle,
                  ),
                ],
              ),
            ),
          ),
        ]),
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
