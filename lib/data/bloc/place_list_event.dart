import 'package:places/data/model/place.dart';

abstract class PlaceListEvent {}

class TogglePlaceListEvent extends PlaceListEvent {
  final Place place;

  TogglePlaceListEvent(this.place);
}
