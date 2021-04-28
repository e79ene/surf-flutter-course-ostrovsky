class NetworkException implements Exception {
  NetworkException({
    required this.method,
    required this.uri,
    required this.code,
    required this.message,
  });

  final String method;
  final String uri;
  final int? code;
  final String? message;

  @override
  String toString() =>
      'В запросе $method \'$uri\' возникла ошибка: $code $message';
}
