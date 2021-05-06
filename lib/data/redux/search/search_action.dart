import 'package:places/data/model/place.dart';

abstract class SearchAction {}

class SearchStringAction implements SearchAction {
  final String searchString;

  const SearchStringAction(this.searchString);
}

class SearchResultAction implements SearchAction {
  final List<Place> places;

  const SearchResultAction(this.places);
}

class SearchErrorAction implements SearchAction {
  final Object error;

  const SearchErrorAction(this.error);
}
