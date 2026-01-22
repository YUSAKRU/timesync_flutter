import 'package:dio/dio.dart';

/// Error Interceptor
/// Handles and transforms DioException to user-friendly error messages
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = 'Bağlantı zaman aşımına uğradı';
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = 'İstek gönderme zaman aşımına uğradı';
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Yanıt alma zaman aşımına uğradı';
        break;
      case DioExceptionType.badCertificate:
        errorMessage = 'Güvenlik sertifikası hatası';
        break;
      case DioExceptionType.badResponse:
        errorMessage = _handleStatusCode(err.response?.statusCode);
        break;
      case DioExceptionType.cancel:
        errorMessage = 'İstek iptal edildi';
        break;
      case DioExceptionType.connectionError:
        errorMessage = 'İnternet bağlantısı yok';
        break;
      case DioExceptionType.unknown:
        errorMessage = 'Beklenmeyen bir hata oluştu';
        break;
    }

    // Try to get error message from response
    if (err.response?.data != null && err.response?.data is Map) {
      final data = err.response?.data as Map;
      if (data.containsKey('message')) {
        errorMessage = data['message'];
      } else if (data.containsKey('error')) {
        errorMessage = data['error'];
      }
    }

    // Create modified exception with user-friendly message
    final modifiedError = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: errorMessage,
      stackTrace: err.stackTrace,
    );

    return handler.next(modifiedError);
  }

  String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Geçersiz istek';
      case 401:
        return 'Yetkilendirme hatası. Lütfen tekrar giriş yapın';
      case 403:
        return 'Bu işlem için yetkiniz yok';
      case 404:
        return 'İstenilen kaynak bulunamadı';
      case 409:
        return 'Çakışma hatası. Bu kayıt zaten mevcut';
      case 422:
        return 'Girdiğiniz bilgiler geçersiz';
      case 429:
        return 'Çok fazla istek gönderildi. Lütfen bekleyin';
      case 500:
        return 'Sunucu hatası oluştu';
      case 502:
        return 'Sunucuya ulaşılamıyor';
      case 503:
        return 'Servis şu anda kullanılamıyor';
      default:
        return 'Bir hata oluştu (Kod: $statusCode)';
    }
  }
}
