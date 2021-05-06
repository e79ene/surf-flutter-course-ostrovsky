import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/data/model/geo_position.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';

class PlaceInteractor extends ChangeNotifier {
  static const myLocation = GeoPositions.moscow;
  static const minRadius = 100.0;
  static const maxRadius = 20000.0;

  final PlaceRepository repo;

  PlaceInteractor(this.repo);

  Future<Place> getPlaceDetails(int id) => repo.getById(id);

  Future<Place> addNewPlace(draft) => repo.create(draft);

  Future<void> deleteById(int id) => repo.deleteById(id);

  final searchHistory = SearchHistory();
}

class SearchHistory {
  void clear() => strings.clear();

  // ignore: unused_element
  void _save(String searchString) {
    remove(searchString);
    strings.insert(0, searchString);
  }

  final strings = <String>[];

  void remove(String searchString) => strings.remove(searchString);
}
