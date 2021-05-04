import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:places/data/model/place.dart';

class PlaceListState extends Equatable {
  final UnmodifiableListView<Place> list;

  PlaceListState(Iterable<Place> iterable)
      : list = UnmodifiableListView<Place>(iterable);

  @override
  List<Object> get props => [list];

  @override
  bool get stringify => true;
}
