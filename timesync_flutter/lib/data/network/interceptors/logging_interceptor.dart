import 'package:dio/dio.dart';

/// Log interceptor - tüm istekleri ve yanıtları loglar
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('🌐 REQUEST[${options.method}] => PATH: ${options.path}');
    print('🔑 Headers: ${options.headers}');
    if (options.data != null) {
      print('📦 Data: ${options.data}');
    }
    if (options.queryParameters.isNotEmpty) {
      print('🔍 Query: ${options.queryParameters}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    print('📥 Data: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('❌ ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    print('⚠️ Message: ${err.message}');
    if (err.response?.data != null) {
      print('📛 Error Data: ${err.response?.data}');
    }
    super.onError(err, handler);
  }
}
