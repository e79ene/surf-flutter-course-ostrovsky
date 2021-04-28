class EndPoint {
  final String method;
  final String path;

  const EndPoint(this.method, this.path);

  static const filtered_places = EndPoint(_POST, '/filtered_places');
  static const POST_place = EndPoint(_POST, '/place');
  static getPlaceById(int id) => EndPoint(_GET, '/place/$id');
  static deletePlaceById(int id) => EndPoint(_DELETE, '/place/$id');
}

const _POST = 'POST';
const _GET = 'GET';
const _DELETE = 'DELETE';
