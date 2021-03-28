import 'package:places/domain/geo_position.dart';

class Sight {
  final String name;
  final GeoPosition geo;
  final String url;
  final String details;
  final String type;

  const Sight(
    this.name, {
    required this.geo,
    required this.url,
    required this.details,
    required this.type,
  });

  @override
  String toString() {
    return 'Sight($name $geo $type)';
  }
}
