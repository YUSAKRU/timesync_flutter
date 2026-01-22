import 'package:dio/dio.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/storage/storage_keys.dart';

/// Authentication interceptor - JWT token yönetimi
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Storage'dan token al
    final storage = await StorageService.getInstance();
    final token = storage.getString(StorageKeys.accessToken);

    // Token varsa header'a ekle
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 401 hatası - token süresi dolmuş
    if (err.response?.statusCode == 401) {
      final storage = await StorageService.getInstance();
      final refreshToken = storage.getString(StorageKeys.refreshToken);

      if (refreshToken != null && refreshToken.isNotEmpty) {
        try {
          // Token yenileme isteği
          // TODO: Token yenileme endpoint'i implement edilecek
          print('🔄 Token yenileniyor...');
          
          // Başarılı olursa isteği tekrarla
          // return handler.resolve(await _retry(err.requestOptions));
        } catch (e) {
          // Token yenileme başarısız - kullanıcıyı çıkış yaptır
          await storage.remove(StorageKeys.accessToken);
          await storage.remove(StorageKeys.refreshToken);
          print('⚠️ Token yenilenemedi, kullanıcı çıkış yapıyor');
        }
      }
    }

    super.onError(err, handler);
  }

  // İsteği tekrar gönder
  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    return Dio().request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
