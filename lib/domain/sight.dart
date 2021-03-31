import 'package:places/domain/geo_position.dart';
import 'package:places/domain/string_utils.dart';

class Sight {
  const Sight(
    this.name, {
    required this.geo,
    required this.url,
    required this.details,
    required this.type,
  });

  final String name;
  final GeoPosition geo;
  final String url;
  final String details;
  final String type;

  String get shortDescription => details.left(20);

  @override
  String toString() {
    return 'Sight($name $geo $type)';
  }
}
