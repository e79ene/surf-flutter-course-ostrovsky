import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/mocks.dart';

final sightRepo = SightRepo();

class SightRepo extends ChangeNotifier {
  final _mocks = generateMocks(10);
  late final List<Place> planned;
  late final List<Place> visited;
  final absentUrl =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png';

  SightRepo() : super() {
    planned = _mocks
        .asMap()
        .entries
        .where((e) => e.key.isOdd)
        .map((e) => e.value)
        .toList();

    visited = _mocks
        .asMap()
        .entries
        .where((e) => e.key.isEven)
        .map((e) => e.value)
        .toList();
  }

  Iterable<Place> get all => _mocks;

  void saveSight(Place sight) {
    _mocks.add(sight);
    notifyListeners();
  }
}
