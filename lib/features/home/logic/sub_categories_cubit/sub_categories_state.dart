import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/sub_categories_response.dart';

part 'sub_categories_state.freezed.dart';

@freezed
class SubCategoriesState with _$SubCategoriesState {
  const factory SubCategoriesState.initial() = _Initial;
  const factory SubCategoriesState.loading() = _Loading;
  const factory SubCategoriesState.success(SubCategoriesResponse subCategories) = _Success;
  const factory SubCategoriesState.error(String message) = _Error;
}
