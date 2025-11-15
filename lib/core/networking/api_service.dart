import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sadiqeen/core/networking/api_constants.dart';
import 'package:sadiqeen/features/home/data/models/categories_response_model.dart';
import 'package:sadiqeen/features/home/data/models/sub_categories_response.dart';
import '../../features/login/data/models/login_request_body.dart';
import '../../features/login/data/models/login_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<LoginResponse> login(@Body() LoginRequestBody loginRequestBody);

  @GET(ApiConstants.categories)
  Future<CategoriesResponse> getCategories();

  

  @GET("categories/{categoryId}/subcategories")
  Future<SubCategoriesResponse> getSubCategories(
    @Path("categoryId") int categoryId,
    @Query("search") String? search,
  );
}
