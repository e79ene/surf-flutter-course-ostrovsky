import 'package:mobx/mobx.dart';
import 'package:places/data/model/category.dart';
import 'package:places/data/model/geo_position.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';

part 'place_store.g.dart';

class PlaceStore = _PlaceStore with _$PlaceStore;

abstract class _PlaceStore with Store {
  static const myLocation = GeoPositions.moscow;
  static const _minRadius = 100.0;
  static const _maxRadius = 20000.0;
  double get minRadius => _minRadius;
  double get maxRadius => _maxRadius;

  final PlaceRepository repo;

  _PlaceStore(this.repo);

  @observable
  double radius = _maxRadius;

  final ObservableSet<Category> categories = ObservableSet<Category>();

  @action
  void toggleCategory(Category category) => categories.contains(category)
      ? categories.remove(category)
      : categories.add(category);

  @action
  void clearFilter() {
    radius = maxRadius;
    categories.clear();
  }

  @computed
  ObservableFuture<List<Place>> get filtered => ObservableFuture<List<Place>>(
        repo.getFiltered(
          center: myLocation,
          radius: radius,
          categories: categories,
        ),
      );
}
