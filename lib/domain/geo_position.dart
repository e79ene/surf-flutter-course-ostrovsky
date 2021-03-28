import 'dart:math';

class GeoPosition {
  final double lat;
  final double lon;

  const GeoPosition(this.lat, this.lon);

  @override
  String toString() => '[$lat, $lon]';

  double distanceTo(GeoPosition other) {
    const metersInDegree = 60 * 1852;
    final mediumLat = (other.lat + lat) / 2;
    final dy = other.lat - lat;
    final dlon = (other.lon - lon - 180) % 360 - 180;
    final dx = dlon * cos(mediumLat * pi / 180);
    final r = sqrt(dy * dy + dx * dx);
    return r * metersInDegree;
  }
}

class GeoPositions {
  static const moscow = GeoPosition(55.751244, 37.618423);
}
