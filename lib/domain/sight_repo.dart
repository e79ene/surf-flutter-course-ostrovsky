import 'package:flutter/cupertino.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';

final sightRepo = SightRepo();

class SightRepo extends ChangeNotifier {
  final _mocks = generateMocks(1);
  final absentUrl =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png';

  Iterable<Sight> get all => _mocks;

  Iterable<Sight> get planned =>
      _mocks.asMap().entries.where((e) => e.key % 2 == 1).map((e) => e.value);

  Iterable<Sight> get visited =>
      _mocks.asMap().entries.where((e) => e.key % 2 == 0).map((e) => e.value);

  void saveSight(Sight sight) {
    _mocks.add(sight);
    notifyListeners();
  }
}
