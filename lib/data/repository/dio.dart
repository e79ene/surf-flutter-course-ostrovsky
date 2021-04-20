import 'package:dio/dio.dart';

final dio = Dio(BaseOptions(
  baseUrl: 'https://test-backend-flutter.surfstudio.ru/',
  connectTimeout: 5000,
  receiveTimeout: 5000,
  sendTimeout: 5000,
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
