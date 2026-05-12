import 'package:dio/dio.dart';
import 'package:farmmitra_app/core/localization/app_locale.dart';

final class LocaleInterceptor extends Interceptor {
  LocaleInterceptor(this.locale);

  final AppLocale locale;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Accept-Language'] = locale.code;
    handler.next(options);
  }
}
