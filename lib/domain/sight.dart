class Sight {
  String name;
  double lat;
  double lon;
  String url;
  String details;
  String type;

  Sight(
    this.name, {
    required this.lat,
    required this.lon,
    required this.url,
    required this.details,
    required this.type,
  });

  @override
  String toString() {
    return 'Sight($name [$lat,$lon] $type)';
  }
}
