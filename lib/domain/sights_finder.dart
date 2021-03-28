import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/geo_position.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';

class SightsFinder extends ChangeNotifier {
  final paramatersNotifier = ChangeNotifier();

  SightsFinder() {
    paramatersNotifier.addListener(() => _search());
  }

  GeoPosition myLocation = GeoPositions.moscow;

  static const minDistance = 100.0;
  static const maxDistance = 20000000.0;
  double _distance = minDistance;

  double get distance => _distance;
  set distance(double d) {
    if (d == _distance) return;

    _distance = d;
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    paramatersNotifier.notifyListeners();
  }

  List<Sight> _result = [];
  Iterable<Sight> get result => _result;

  void _search() {
    final eq = const ListEquality<Sight>().equals;
    final r = mocks
        .where((sight) => myLocation.distanceTo(sight.geo) <= _distance)
        .toList();

    if (eq(r, _result)) return;

    _result = r;
    notifyListeners();
  }
}

final sightsFinder = SightsFinder();
