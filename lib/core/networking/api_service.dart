import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sadiqeen/core/networking/api_constants.dart';
import '../../features/login/data/models/login_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<LoginResponse> login(@Body() Map<String, dynamic> loginRequestBody);
}
