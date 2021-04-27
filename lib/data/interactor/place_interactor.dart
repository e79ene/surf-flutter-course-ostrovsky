import 'dart:async';

import 'package:places/data/model/category.dart';
import 'package:places/data/model/geo_position.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:relation/relation.dart';

class PlaceInteractor {
  static const myLocation = GeoPositions.moscow;
  static const minRadius = 100.0;
  static const maxRadius = 20000.0;

  final PlaceRepository repo;
  double _radius = maxRadius;
  final Set<Category> _categories = {};
  final filteredPlaces = EntityStreamedState<List<Place>>();
  final favorite = StreamedState<List<Place>>([]);
  final Map<int, Place> _visited = {};

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

  void dispose() {
    filteredPlaces.dispose();
  }

  void _updateFilter() async {
    filteredPlaces.loading();
    filteredPlaces.content(await getPlaces(_radius, _categories));
  }

  Future<List<Place>> getPlaces(
    double radius,
    Set<Category> categories, [
    String? nameFilter,
  ]) =>
      repo.getFiltered(
        center: myLocation,
        radius: radius,
        categories: categories,
      );

  Future<Place> getPlaceDetails(int id) async => await repo.getById(id);

  void _addToFavorite(Place place) =>
      favorite.accept(List<Place>.from(favorite.value!)..insert(0, place));

  void removeFromFavorite(Place place) =>
      favorite.accept(List<Place>.from(favorite.value!)..remove(place));

  void toggleFavorite(Place place) => favorite.value!.contains(place)
      ? removeFromFavorite(place)
      : _addToFavorite(place);

  List<Place> getVisited() => _visited.values.toList();

  void addToVisited(place) => _visited[place.id] = place;

  Future<Place> addNewPlace(draft) => repo.create(draft);

  Future<void> deleteById(int id) => repo.deleteById(id);

  Future<Iterable<Place>> search(String searchString) {
    searchHistory._save(searchString);

    return repo.getFiltered(
      center: myLocation,
      radius: _radius,
      categories: _categories,
      nameFilter: searchString,
    );
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

final placeInteractor = PlaceInteractor(PlaceRepository());
