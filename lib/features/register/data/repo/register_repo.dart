import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../models/register_request_model.dart';
import '../models/register_response_model.dart';

class RegisterRepo {
  final ApiService _apiService;
  RegisterRepo(this._apiService);

  Future<ApiResult<RegisterResponseModel>> register(
    RegisterRequestModel registerRequestBody,
  ) async {
    try {
      final response = await _apiService.register(registerRequestBody);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
