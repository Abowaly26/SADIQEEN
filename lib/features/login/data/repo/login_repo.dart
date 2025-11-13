import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../models/login_request_body.dart';
import '../models/login_response.dart';

class LoginRepo {
  final ApiService _apiService;
  LoginRepo(this._apiService);

  Future<ApiResult<LoginResponse>> login(
    LoginRequestBody loginRequestBody,
  ) async {
    try {
      print('🟢 LoginRepo: Calling API...');
      final response = await _apiService.login(loginRequestBody.toJson());
      print('🟢 LoginRepo: Success! Response: $response');
      return ApiResult.success(response);
    } catch (e) {
      print('🔴 LoginRepo: Error caught!');
      print('🔴 Error Type: ${e.runtimeType}');
      print('🔴 Error: $e');
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
