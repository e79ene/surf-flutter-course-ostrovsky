import 'package:places/data/model/place.dart';

abstract class SearchState {}

class SearchNoSearchState implements SearchState {}

class SearchLoadingState implements SearchState {}

class SearchErrorState implements SearchState {}

class SearchNotFoundState implements SearchState {}

class SearchResultState implements SearchState {
  final List<Place> places;

  const SearchResultState(this.places) : assert(places.length > 0);
}
