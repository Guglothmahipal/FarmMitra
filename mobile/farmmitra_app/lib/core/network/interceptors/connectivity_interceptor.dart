import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:farmmitra_app/core/errors/app_exception.dart';

final class ConnectivityInterceptor extends QueuedInterceptor {
  ConnectivityInterceptor({Connectivity? connectivity})
    : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final results = await _connectivity.checkConnectivity();
    final isOffline =
        results.isEmpty ||
        results.every((result) => result == ConnectivityResult.none);

    if (isOffline) {
      handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          error: const AppException(
            code: 'offline',
            message: 'No internet connection available',
          ),
        ),
      );
      return;
    }

    handler.next(options);
  }
}
