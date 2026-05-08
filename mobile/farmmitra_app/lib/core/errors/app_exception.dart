import 'package:dio/dio.dart';

final class AppException implements Exception {
  const AppException({
    required this.message,
    this.code,
    this.statusCode,
    this.stackTrace,
  });

  factory AppException.fromDio(DioException error, StackTrace stackTrace) {
    final statusCode = error.response?.statusCode;
    final responseData = error.response?.data;

    return AppException(
      code: _codeFromDio(error),
      statusCode: statusCode,
      stackTrace: stackTrace,
      message: _messageFromResponse(responseData) ?? _messageFromDio(error),
    );
  }

  final String message;
  final String? code;
  final int? statusCode;
  final StackTrace? stackTrace;

  static String _codeFromDio(DioException error) {
    return switch (error.type) {
      DioExceptionType.connectionTimeout => 'connection_timeout',
      DioExceptionType.sendTimeout => 'send_timeout',
      DioExceptionType.receiveTimeout => 'receive_timeout',
      DioExceptionType.badCertificate => 'bad_certificate',
      DioExceptionType.badResponse => 'bad_response',
      DioExceptionType.cancel => 'request_cancelled',
      DioExceptionType.connectionError => 'connection_error',
      DioExceptionType.unknown => 'unknown_network_error',
    };
  }

  static String _messageFromDio(DioException error) {
    return switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => 'The server took too long to respond',
      DioExceptionType.connectionError => 'Unable to connect to the server',
      DioExceptionType.badResponse => 'The server returned an error',
      DioExceptionType.cancel => 'The request was cancelled',
      DioExceptionType.badCertificate => 'The server certificate is invalid',
      DioExceptionType.unknown => 'Unexpected network error',
    };
  }

  static String? _messageFromResponse(Object? data) {
    if (data is Map<String, dynamic>) {
      final message = data['message'] ?? data['error'];
      if (message is String && message.isNotEmpty) {
        return message;
      }
    }

    return null;
  }

  @override
  String toString() => 'AppException($code, $statusCode): $message';
}
