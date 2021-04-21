import 'dart:math';

class GeoPosition {
  final double lat;
  final double lng;

  const GeoPosition(this.lat, this.lng);

  @override
  String toString() => '[$lat, $lng]';

  double distanceTo(GeoPosition other) {
    const metersInDegree = 60 * 1852;
    final mediumLat = (other.lat + lat) / 2;
    final dy = other.lat - lat;
    final dlng = (other.lng - lng - 180) % 360 - 180;
    final dx = dlng * cos(mediumLat * pi / 180);
    final r = sqrt(dy * dy + dx * dx);
    return r * metersInDegree;
  }
}

class GeoPositions {
  static const moscow = GeoPosition(55.751244, 37.618423);
}
