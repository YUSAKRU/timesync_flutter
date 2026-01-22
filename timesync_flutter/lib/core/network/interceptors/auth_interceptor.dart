import 'package:dio/dio.dart';

import '../../storage/storage_keys.dart';
import '../../storage/storage_service.dart';
import '../api_config.dart';

/// Authentication Interceptor
/// Adds JWT token to all requests
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Get token from Secure Storage
    final storage = await StorageService.getInstance();
    final token = await storage.getSecureString(StorageKeys.accessToken);

    // Add token to headers if available
    if (token != null && token.isNotEmpty) {
      options.headers[ApiConfig.authorizationHeader] =
          '${ApiConfig.bearerPrefix} $token';
    }

    return handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    // Handle token refresh if needed
    // Check for new token in response headers
    final newToken = response.headers.value('x-new-token');
    if (newToken != null) {
      _saveToken(newToken);
    }

    return handler.next(response);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Handle 401 Unauthorized
    if (err.response?.statusCode == 401) {
      // Try to refresh token
      final refreshed = await _refreshToken();

      if (refreshed) {
        // Retry the request with new token
        try {
          final options = err.requestOptions;
          final storage = await StorageService.getInstance();
          final token = await storage.getSecureString(StorageKeys.accessToken);

          options.headers[ApiConfig.authorizationHeader] =
              '${ApiConfig.bearerPrefix} $token';

          final dio = Dio();
          final response = await dio.request(
            options.path,
            options: Options(
              method: options.method,
              headers: options.headers,
            ),
            data: options.data,
            queryParameters: options.queryParameters,
          );

          return handler.resolve(response);
        } catch (e) {
          return handler.next(err);
        }
      } else {
        // Refresh failed, logout user
        await _clearTokens();
        return handler.next(err);
      }
    }

    return handler.next(err);
  }

  Future<bool> _refreshToken() async {
    try {
      final storage = await StorageService.getInstance();
      final refreshToken =
          await storage.getSecureString(StorageKeys.refreshToken);

      if (refreshToken == null) return false;

      final dio = Dio();
      final response = await dio.post(
        '${ApiConfig.currentBaseUrl}${ApiConfig.refreshToken}',
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200) {
        final newAccessToken = response.data['access_token'];
        final newRefreshToken = response.data['refresh_token'];

        await storage.setSecureString(StorageKeys.accessToken, newAccessToken);
        await storage.setSecureString(
            StorageKeys.refreshToken, newRefreshToken);

        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> _saveToken(String token) async {
    final storage = await StorageService.getInstance();
    await storage.setSecureString(StorageKeys.accessToken, token);
  }

  Future<void> _clearTokens() async {
    final storage = await StorageService.getInstance();
    await storage.deleteSecure(StorageKeys.accessToken);
    await storage.deleteSecure(StorageKeys.refreshToken);
    await storage.deleteSecure(StorageKeys.userId);
    await storage.remove(StorageKeys.userRole);
  }
}
