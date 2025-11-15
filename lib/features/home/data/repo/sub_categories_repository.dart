import 'package:dio/dio.dart';
import 'package:sadiqeen/core/networking/api_error_handler.dart';
import 'package:sadiqeen/features/home/data/models/sub_categories_response.dart';
import '../../../../core/networking/api_service.dart';
import '../../../../core/networking/api_result.dart';

class SubCategoriesRepository {
  final ApiService apiService;

  SubCategoriesRepository({required this.apiService});

  Future<ApiResult<SubCategoriesResponse>> getSubCategories({
    required int categoryId,
    String? search,
  }) async {
    try {
      final response = await apiService.getSubCategories(categoryId, search);
      return ApiResult.success(response);
    } on DioException catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
