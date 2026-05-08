import 'package:dio/dio.dart';

final class RequestIdInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['X-Request-Id'] =
        '${DateTime.now().microsecondsSinceEpoch}-${options.hashCode}';
    options.headers['X-Client-Platform'] = 'mobile-flutter';
    handler.next(options);
  }
}
