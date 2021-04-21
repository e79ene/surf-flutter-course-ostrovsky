import 'package:places/data/model/category.dart';
import 'package:places/data/model/geo_position.dart';

class Place {
  const Place({
    required this.id,
    required this.name,
    required this.geo,
    required this.urls,
    required this.description,
    required this.category,
  }) : assert(urls.length > 0);

  const Place.draft({
    required String name,
    required GeoPosition geo,
    required List<String> urls,
    required String description,
    required Category category,
  }) : this(
          id: 0,
          name: name,
          geo: geo,
          urls: urls,
          description: description,
          category: category,
        );

  final int id;
  final String name;
  final GeoPosition geo;
  final List<String> urls;
  final String description;
  final Category category;

  String get url => urls.first;

  @override
  String toString() {
    return 'Place($name $geo $category)';
  }
}

class PlaceDto extends Place implements Comparable {
  final double distance;

  const PlaceDto({
    required id,
    required name,
    required geo,
    required urls,
    required description,
    required category,
    required this.distance,
  })  : assert(distance >= 0),
        super(
          id: id,
          name: name,
          geo: geo,
          urls: urls,
          description: description,
          category: category,
        );

  @override
  int compareTo(other) => distance.compareTo(other.distance);
}
