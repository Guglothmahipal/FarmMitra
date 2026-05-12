import 'package:dio/dio.dart';
import 'package:farmmitra_app/core/localization/app_locale.dart';
import 'package:farmmitra_app/core/localization/localization_service.dart';

final class LocaleInterceptor extends Interceptor {
  LocaleInterceptor(this.locale);

  final AppLocale locale;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Accept-Language'] =
        LocalizationService.acceptLanguageHeader(locale);
    handler.next(options);
  }
}
