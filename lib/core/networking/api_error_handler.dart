import 'package:dio/dio.dart';
import 'api_error_model.dart';
import 'api_constants.dart';

enum DataSource {
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORIZED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT,
}

class ResponseCode {
  static const int SUCCESS = 200;
  static const int NO_CONTENT = 201;
  static const int BAD_REQUEST = 400;
  static const int UNAUTHORIZED = 401;
  static const int FORBIDDEN = 403;
  static const int NOT_FOUND = 404;
  static const int INTERNAL_SERVER_ERROR = 500;
  static const int API_LOGIC_ERROR = 422;

  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECEIVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static const String NO_CONTENT = "لا يوجد بيانات";
  static const String BAD_REQUEST = "طلب غير صحيح";
  static const String UNAUTHORIZED = "غير مسموح بالدخول، يرجي تسجيل الدخول";
  static const String FORBIDDEN = "غير مسموح بالدخول";
  static const String INTERNAL_SERVER_ERROR = "خطأ في السيرفر، حاول لاحقاً";
  static const String NOT_FOUND = "العنصر غير موجود";

  static String CONNECT_TIMEOUT = "انتهى وقت الاتصال بالسيرفر";
  static String CANCEL = "تم إلغاء الطلب";
  static String RECEIVE_TIMEOUT = "انتهى وقت استلام البيانات";
  static String SEND_TIMEOUT = "انتهى وقت إرسال البيانات";
  static String CACHE_ERROR = "خطأ في الذاكرة المؤقتة";
  static String NO_INTERNET_CONNECTION = "لا يوجد اتصال بالإنترنت";
  static String DEFAULT = "حدث خطأ غير متوقع";
}

extension DataSourceExtension on DataSource {
  ApiErrorModel getFailure() {
    switch (this) {
      case DataSource.NO_CONTENT:
        return ApiErrorModel(
          message: ResponseMessage.NO_CONTENT,
          type: '',
          status: ResponseCode.NO_CONTENT,
          showToast: true,
        );
      case DataSource.BAD_REQUEST:
        return ApiErrorModel(
          message: ResponseMessage.BAD_REQUEST,
          type: '',
          status: ResponseCode.BAD_REQUEST,
          showToast: true,
        );
      case DataSource.FORBIDDEN:
        return ApiErrorModel(
          message: ResponseMessage.FORBIDDEN,
          type: '',
          status: ResponseCode.FORBIDDEN,
          showToast: true,
        );
      case DataSource.UNAUTHORIZED:
        return ApiErrorModel(
          message: ResponseMessage.UNAUTHORIZED,
          type: '',
          status: ResponseCode.UNAUTHORIZED,
          showToast: true,
        );
      case DataSource.NOT_FOUND:
        return ApiErrorModel(
          message: ResponseMessage.NOT_FOUND,
          type: '',
          status: ResponseCode.NOT_FOUND,
          showToast: true,
        );
      case DataSource.INTERNAL_SERVER_ERROR:
        return ApiErrorModel(
          message: ResponseMessage.INTERNAL_SERVER_ERROR,
          type: '',
          status: ResponseCode.INTERNAL_SERVER_ERROR,
          showToast: true,
        );
      case DataSource.CONNECT_TIMEOUT:
        return ApiErrorModel(
          message: ResponseMessage.CONNECT_TIMEOUT,
          type: '',
          status: ResponseCode.CONNECT_TIMEOUT,
          showToast: true,
        );
      case DataSource.CANCEL:
        return ApiErrorModel(
          message: ResponseMessage.CANCEL,
          type: '',
          status: ResponseCode.CANCEL,
          showToast: false,
        );
      case DataSource.RECEIVE_TIMEOUT:
        return ApiErrorModel(
          message: ResponseMessage.RECEIVE_TIMEOUT,
          type: '',
          status: ResponseCode.RECEIVE_TIMEOUT,
          showToast: true,
        );
      case DataSource.SEND_TIMEOUT:
        return ApiErrorModel(
          message: ResponseMessage.SEND_TIMEOUT,
          type: '',
          status: ResponseCode.SEND_TIMEOUT,
          showToast: true,
        );
      case DataSource.CACHE_ERROR:
        return ApiErrorModel(
          message: ResponseMessage.CACHE_ERROR,
          type: '',
          status: ResponseCode.CACHE_ERROR,
          showToast: true,
        );
      case DataSource.NO_INTERNET_CONNECTION:
        return ApiErrorModel(
          message: ResponseMessage.NO_INTERNET_CONNECTION,
          type: '',
          status: ResponseCode.NO_INTERNET_CONNECTION,
          showToast: true,
        );
      case DataSource.DEFAULT:
        return ApiErrorModel(
          message: ResponseMessage.DEFAULT,
          type: '',
          status: ResponseCode.DEFAULT,
          showToast: true,
        );
    }
  }
}

class ErrorHandler implements Exception {
  late ApiErrorModel apiErrorModel;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      apiErrorModel = _handleError(error);
    } else {
      apiErrorModel = DataSource.DEFAULT.getFailure();
    }
  }
}

ApiErrorModel _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.RECEIVE_TIMEOUT.getFailure();
    case DioExceptionType.badResponse:
      return _parseServerError(error);
    case DioExceptionType.unknown:
      if (error.message != null) {
        if (error.message!.contains("SocketException") ||
            error.message!.contains("Failed host lookup")) {
          return DataSource.NO_INTERNET_CONNECTION.getFailure();
        }
        if (error.message!.contains("CERTIFICATE_VERIFY_FAILED") ||
            error.message!.contains("HandshakeException")) {
          return ApiErrorModel(
            message: 'خطأ في الاتصال الآمن (SSL)',
            type: '',
            status: -1,
            showToast: true,
          );
        }
      }
      return ApiErrorModel(
        message: error.message ?? 'حدث خطأ غير متوقع',
        type: '',
        status: -1,
        showToast: true,
      );
    case DioExceptionType.cancel:
      return DataSource.CANCEL.getFailure();
    case DioExceptionType.connectionError:
      return DataSource.NO_INTERNET_CONNECTION.getFailure();
    case DioExceptionType.badCertificate:
      return DataSource.DEFAULT.getFailure();
  }
}

ApiErrorModel _parseServerError(DioException error) {
  try {
    final response = error.response;
    if (response != null && response.data != null) {
      // Try to parse the error from the response
      if (response.data is Map<String, dynamic>) {
        return ApiErrorModel.fromJson(response.data);
      } else if (response.data is String) {
        // If the response is a string, create a custom error
        return ApiErrorModel(
          message: response.data.toString(),
          type: '',
          status: response.statusCode,
          showToast: true,
        );
      }
    }

    // Fallback based on status code
    switch (response?.statusCode) {
      case ResponseCode.BAD_REQUEST:
        return DataSource.BAD_REQUEST.getFailure();
      case ResponseCode.UNAUTHORIZED:
        return DataSource.UNAUTHORIZED.getFailure();
      case ResponseCode.FORBIDDEN:
        return DataSource.FORBIDDEN.getFailure();
      case ResponseCode.NOT_FOUND:
        return DataSource.NOT_FOUND.getFailure();
      case ResponseCode.INTERNAL_SERVER_ERROR:
        return DataSource.INTERNAL_SERVER_ERROR.getFailure();
      case ResponseCode.API_LOGIC_ERROR:
        return ApiErrorModel(
          message: 'خطأ في البيانات المدخلة',
          type: '',
          status: ResponseCode.API_LOGIC_ERROR,
          showToast: true,
        );
      default:
        return DataSource.DEFAULT.getFailure();
    }
  } catch (_) {
    return DataSource.DEFAULT.getFailure();
  }
}
