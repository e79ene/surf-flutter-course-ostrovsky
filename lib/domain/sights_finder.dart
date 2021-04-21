import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:places/data/model/category.dart';
import 'package:places/data/model/geo_position.dart';
import 'package:places/data/model/place.dart';
import 'package:places/domain/sight_repo.dart';

class SightsFinder extends ChangeNotifier {
  final paramatersNotifier = ChangeNotifier();
  void _notifyParametersListeners() {
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    paramatersNotifier.notifyListeners();
  }

  SightsFinder() {
    paramatersNotifier.addListener(() => _filter());
    sightRepo.addListener(() => _filter());
    _filter();
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

  final Set<Category> _categories = {};

  bool hasCategory(Category category) => _categories.contains(category);

  void toggleCategory(Category category) {
    _categories.contains(category)
        ? _categories.remove(category)
        : _categories.add(category);
    _notifyParametersListeners();
  }

  List<Place> _filtered = [];
  List<Place> get filtered => _filtered;

  void _filter() {
    final eq = const ListEquality<Place>().equals;
    final r = sightRepo.all.where(_criteria).toList();

    if (eq(r, _filtered)) return;

    _filtered = r;
    notifyListeners();
  }

  bool _criteria(Place sight) {
    final inRange = myLocation.distanceTo(sight.geo) <= _distance;
    final inCategory =
        _categories.isEmpty ? true : _categories.contains(sight.category);

    return inRange && inCategory;
  }

  Future<Iterable<Place>> search(String searchString) async {
    searchHistory._save(searchString);

    return await Future.delayed(
      Duration(seconds: 2),
      () => _matched(searchString),
    );
  }

  Iterable<Place> _matched(String text) {
    return _filtered.where((sight) =>
        '${sight.category} ${sight.name} ${sight.description}'.contains(text));
  }

  final searchHistory = SearchHistory();
}

class SearchHistory {
  Iterable<String> get strings => _strings;

  void clear() => _strings.clear();

  void _save(String searchString) {
    remove(searchString);
    _strings.insert(0, searchString);
  }

  final _strings = <String>[];

  void remove(String searchString) => _strings.remove(searchString);
}

final sightsFinder = SightsFinder();
