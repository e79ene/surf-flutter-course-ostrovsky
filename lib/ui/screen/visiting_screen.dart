import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
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
            makeSightView: (sight) => SightCard(sight),
          ),
          _VisitingList(
            sights: mocks
                .asMap()
                .entries
                .where((e) => e.key % 2 == 0)
                .map((e) => e.value),
            makeSightView: (sight) => SightCard(sight),
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
