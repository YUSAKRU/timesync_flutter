import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Logging Interceptor
/// Logs all HTTP requests and responses for debugging
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print('╔══════════════════════════════════════════════════════════════');
      print('║ 📤 REQUEST');
      print('╠══════════════════════════════════════════════════════════════');
      print('║ Method: ${options.method}');
      print('║ URL: ${options.uri}');
      print('║ Headers: ${options.headers}');
      
      if (options.queryParameters.isNotEmpty) {
        print('║ Query Parameters: ${options.queryParameters}');
      }
      
      if (options.data != null) {
        print('║ Body: ${options.data}');
      }
      
      print('╚══════════════════════════════════════════════════════════════');
    }
    
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print('╔══════════════════════════════════════════════════════════════');
      print('║ 📥 RESPONSE');
      print('╠══════════════════════════════════════════════════════════════');
      print('║ Status Code: ${response.statusCode}');
      print('║ URL: ${response.requestOptions.uri}');
      
      if (response.headers.map.isNotEmpty) {
        print('║ Headers: ${response.headers.map}');
      }
      
      if (response.data != null) {
        print('║ Body: ${response.data}');
      }
      
      print('╚══════════════════════════════════════════════════════════════');
    }
    
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print('╔══════════════════════════════════════════════════════════════');
      print('║ ❌ ERROR');
      print('╠══════════════════════════════════════════════════════════════');
      print('║ Type: ${err.type}');
      print('║ Message: ${err.message}');
      print('║ URL: ${err.requestOptions.uri}');
      
      if (err.response != null) {
        print('║ Status Code: ${err.response?.statusCode}');
        print('║ Response: ${err.response?.data}');
      }
      
      if (err.stackTrace != null) {
        print('║ Stack Trace: ${err.stackTrace}');
      }
      
      print('╚══════════════════════════════════════════════════════════════');
    }
    
    return handler.next(err);
  }
}
