import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory._();

  static Dio? _dio;

  static Dio getDio() {
    const Duration timeOut = Duration(seconds: 30);

    if (_dio == null) {
      _dio = Dio(
        BaseOptions(
          connectTimeout: timeOut,
          receiveTimeout: timeOut,
          contentType: 'application/json',
          headers: {
            'Accept': 'application/json',
            // 🌐 اللغة الافتراضية: عربي
            'lang': 'ar',
            'User-Agent':
                'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
          },
        ),
      );

      _addInterceptors();
    }

    return _dio!;
  }

  /// 🔄 تحديث language header في كل طلبات الـ API
  /// يتم استدعاؤها عند تغيير اللغة من الإعدادات
  static void updateLanguage(String languageCode) {
    if (_dio != null) {
      _dio!.options.headers['lang'] = languageCode;
      print('🌐 Language header updated to: $languageCode');
    }
  }

  /// 🚀 تهيئة اللغة من SharedPreferences عند بدء التطبيق
  /// يتم استدعاؤها في main.dart
  static void initializeLanguage(String languageCode) {
    getDio(); // التأكد من تهيئة Dio
    updateLanguage(languageCode);
  }

  static void _addInterceptors() {
    _dio?.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('🟡 ========== REQUEST DETAILS ==========');
          print('🟡 URL: ${options.uri}');
          print('🟡 Method: ${options.method}');
          print('🟡 Headers: ${options.headers}');
          print('🟡 Body: ${options.data}');
          print('🟡 =======================================');
          handler.next(options);
        },
        onResponse: (response, handler) {
          print('🟢 ========== RESPONSE DETAILS ==========');
          print('🟢 Status Code: ${response.statusCode}');
          print('🟢 Data: ${response.data}');
          print('🟢 ========================================');
          handler.next(response);
        },
        onError: (DioException error, handler) {
          print('🔴 ========== DIO ERROR DETAILS ==========');
          print('🔴 Type: ${error.type}');
          print('🔴 Message: ${error.message}');
          print('🔴 Error Object: ${error.error}');
          print('🔴 Response: ${error.response?.data}');
          print('🔴 Status Code: ${error.response?.statusCode}');
          print('🔴 ========================================');
          handler.next(error);
        },
      ),
    );

    _dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
        error: true,
        responseBody: true,
      ),
    );
  }
}
