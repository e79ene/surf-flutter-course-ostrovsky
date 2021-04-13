import 'package:places/domain/geo_position.dart';
import 'package:places/domain/string_utils.dart';

class Sight {
  const Sight(
    this.name, {
    required this.geo,
    required this.photoUrls,
    required this.details,
    required this.type,
  });

  final String name;
  final GeoPosition geo;
  final List<String> photoUrls;
  String get url => photoUrls[0];
  final String details;
  final String type;

  String get shortDescription => details.left(20);

  @override
  String toString() {
    return 'Sight($name $geo $type)';
  }
}
