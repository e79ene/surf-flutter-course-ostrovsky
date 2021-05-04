import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/data/model/category.dart';
import 'package:places/data/model/geo_position.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/network_exception.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:relation/relation.dart';

class PlaceInteractor extends ChangeNotifier {
  static const myLocation = GeoPositions.moscow;
  static const minRadius = 100.0;
  static const maxRadius = 20000.0;

  final PlaceRepository repo;
  double _radius = maxRadius;
  final Set<Category> _categories = {};
  final filteredPlaces = EntityStreamedState<List<Place>>();
  final foundPlaces = EntityStreamedState<List<Place>>();

  PlaceInteractor(this.repo) {
    _updateFilter();
  }

  clearFilter() {
    _radius = maxRadius;
    _categories.clear();
    _updateFilter();
  }

  double get radius => _radius;
  set radius(double d) {
    if (d == _radius) return;

    _radius = d;
    _updateFilter();
  }

  bool hasCategory(Category category) => _categories.contains(category);

  void toggleCategory(Category category) {
    _categories.contains(category)
        ? _categories.remove(category)
        : _categories.add(category);
    _updateFilter();
  }

  @override
  void dispose() {
    filteredPlaces.dispose();
    foundPlaces.dispose();
    super.dispose();
  }

  void _updateFilter() async {
    notifyListeners();
    try {
      filteredPlaces.loading();
      filteredPlaces.content(await _getPlaces(_radius, _categories));
    } on NetworkException catch (e) {
      filteredPlaces.error(e);
    }
  }

  Future<List<Place>> _getPlaces(
    double radius,
    Set<Category> categories,
  ) =>
      repo.getFiltered(
        center: myLocation,
        radius: radius,
        categories: categories,
      );

  Future<Place> getPlaceDetails(int id) => repo.getById(id);

  Future<Place> addNewPlace(draft) => repo.create(draft);

  Future<void> deleteById(int id) => repo.deleteById(id);

  void search(String searchString) async {
    searchHistory._save(searchString);

    try {
      foundPlaces.loading();

      final filtered = await repo.getFiltered(
        center: myLocation,
        radius: _radius,
        categories: _categories,
        nameFilter: searchString,
      );

      foundPlaces.content(filtered);
    } on NetworkException catch (e) {
      foundPlaces.error(e);
    }
  }

  final searchHistory = SearchHistory();
}

class SearchHistory {
  void clear() => strings.clear();

  void _save(String searchString) {
    remove(searchString);
    strings.insert(0, searchString);
  }

  final strings = <String>[];

  void remove(String searchString) => strings.remove(searchString);
}
