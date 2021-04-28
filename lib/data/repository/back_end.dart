import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:places/data/repository/endpoint.dart';
import 'package:places/data/repository/network_exception.dart';

final _dio = Dio(BaseOptions(
  baseUrl: 'https://test-backend-flutter.surfstudio.ru/',
  connectTimeout: 5000,
  receiveTimeout: 5000,
  sendTimeout: 5000,
  validateStatus: (status) => true, // Make Dio don't throw on non 2xx statuses
))
  ..interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      final data = options.data?.toString();
      final msg = data?.isNotEmpty == true ? '\n$data' : '';
      print('REQUEST: ${options.path}$msg');
      return handler.next(options);
    },
    onResponse: (response, handler) {
      print(
        'RESPONSE: ${response.statusCode} for ' +
            '${response.requestOptions.method} ${response.requestOptions.path}',
      );
      return handler.next(response);
    },
    onError: (e, handler) {
      final data = e.response?.data != null ? '\n${e.response!.data}' : '';
      print(
          'Dio ERROR for ${e.requestOptions.method} ${e.requestOptions.path}:' +
              '\n${e.message}$data');
      return handler.next(e);
    },
  ));

Future<Response> requestBackend(EndPoint endpoint, [Object? data]) async {
  final response = await _dio.request(
    endpoint.path,
    options: Options(method: endpoint.method),
    data: jsonEncode(data),
  );

  final statusCode = response.statusCode;
  if (statusCode == null || statusCode < 200 || statusCode >= 300)
    throw NetworkException(
      method: response.requestOptions.method,
      uri: response.requestOptions.path,
      code: statusCode,
      message: response.statusMessage,
    );

  return response;
}
