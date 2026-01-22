import 'package:dio/dio.dart';

/// Error handling interceptor - Hataları Türkçe mesajlara çevirir
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
      case DioExceptionType.badResponse:
        errorMessage = _handleResponseError(err.response);
        break;
      case DioExceptionType.cancel:
        errorMessage = 'İstek iptal edildi';
        break;
      case DioExceptionType.connectionError:
        errorMessage = 'İnternet bağlantısı yok';
        break;
      default:
        errorMessage = 'Beklenmeyen bir hata oluştu';
    }

    // Hata mesajını güncelle
    final modifiedErr = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: errorMessage,
    );

    super.onError(modifiedErr, handler);
  }

  String _handleResponseError(Response? response) {
    if (response == null) return 'Sunucudan yanıt alınamadı';

    switch (response.statusCode) {
      case 400:
        return _extractMessage(response.data) ?? 'Geçersiz istek';
      case 401:
        return 'Oturum süreniz doldu, lütfen tekrar giriş yapın';
      case 403:
        return 'Bu işlem için yetkiniz yok';
      case 404:
        return 'İstenen kaynak bulunamadı';
      case 409:
        return _extractMessage(response.data) ?? 'Çakışma hatası';
      case 422:
        return _extractMessage(response.data) ?? 'Doğrulama hatası';
      case 500:
        return 'Sunucu hatası';
      case 503:
        return 'Servis şu anda kullanılamıyor';
      default:
        return 'Bir hata oluştu (${response.statusCode})';
    }
  }

  String? _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message'] ?? data['error'] ?? data['detail'];
    }
    return null;
  }
}
