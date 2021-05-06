import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';

class PlaceInteractor extends ChangeNotifier {
  final PlaceRepository repo;

  PlaceInteractor(this.repo);

  Future<Place> getPlaceDetails(int id) => repo.getById(id);

  Future<Place> addNewPlace(draft) => repo.create(draft);

  Future<void> deleteById(int id) => repo.deleteById(id);
}
