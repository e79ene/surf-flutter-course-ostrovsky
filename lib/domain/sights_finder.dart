import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/geo_position.dart';
import 'package:places/domain/sight.dart';
import 'package:places/domain/sight_repo.dart';

class SightsFinder extends ChangeNotifier {
  final paramatersNotifier = ChangeNotifier();
  void _notifyParametersListeners() {
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    paramatersNotifier.notifyListeners();
  }

  SightsFinder() {
    paramatersNotifier.addListener(() => _search());
    sightRepo.addListener(() => _search());
    _search();
  }

  static const GeoPosition myLocation = GeoPositions.moscow;

  static const minDistance = 100.0;
  static const maxDistance = 20000000.0;
  double _distance = maxDistance;

  double get distance => _distance;
  set distance(double d) {
    if (d == _distance) return;

    _distance = d;
    _notifyParametersListeners();
  }

  final Set<String> _categories = {};

  bool hasCategory(String category) => _categories.contains(category);

  void toggleCategory(String category) {
    _categories.contains(category)
        ? _categories.remove(category)
        : _categories.add(category);
    _notifyParametersListeners();
  }

  List<Sight> _result = [];
  Iterable<Sight> get result => _result;

  void _search() {
    final eq = const ListEquality<Sight>().equals;
    final r = sightRepo.all.where(_criteria).toList();

    if (eq(r, _result)) return;

    _result = r;
    notifyListeners();
  }

  bool _criteria(Sight sight) {
    final inRange = myLocation.distanceTo(sight.geo) <= _distance;
    final inCategory =
        _categories.isEmpty ? true : _categories.contains(sight.type);

    return inRange && inCategory;
  }
}

final sightsFinder = SightsFinder();
