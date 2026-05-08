import 'package:dio/dio.dart';
import 'package:farmmitra_app/config/env/app_config_provider.dart';
import 'package:farmmitra_app/core/network/interceptors/auth_interceptor.dart';
import 'package:farmmitra_app/core/network/interceptors/connectivity_interceptor.dart';
import 'package:farmmitra_app/core/network/interceptors/request_id_interceptor.dart';
import 'package:farmmitra_app/core/storage/secure_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  final config = ref.watch(appConfigProvider);

  final dio = Dio(
    BaseOptions(
      baseUrl: config.apiBaseUrl,
      connectTimeout: Duration(seconds: config.apiTimeoutSeconds),
      receiveTimeout: Duration(seconds: config.apiTimeoutSeconds),
      sendTimeout: Duration(seconds: config.apiTimeoutSeconds),
      headers: const {
        Headers.acceptHeader: Headers.jsonContentType,
        Headers.contentTypeHeader: Headers.jsonContentType,
      },
    ),
  );

  dio.interceptors.addAll([
    RequestIdInterceptor(),
    ConnectivityInterceptor(),
    AuthInterceptor(ref.watch(secureStorageProvider)),
    if (config.enableNetworkLogging)
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) {
          // Keep logging replaceable; wire this to Crashlytics/Sentry later.
          // ignore: avoid_print
          print(object);
        },
      ),
  ]);

  return dio;
});
