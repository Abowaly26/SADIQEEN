import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/categories_response_model.dart';

part 'categories_state.freezed.dart';

@freezed
class CategoriesState with _$CategoriesState {
  const factory CategoriesState.initial() = _Initial;
  const factory CategoriesState.loading() = _Loading;
  const factory CategoriesState.success(List<Category> categories) = _Success;
  const factory CategoriesState.failure(String message) = _Failure;
  
  // Add a method to check the current state
  static String getStateName(CategoriesState state) {
    return state.when(
      initial: () => 'Initial',
      loading: () => 'Loading',
      success: (categories) => 'Success (${categories.length} items)',
      failure: (message) => 'Failure: $message',
    );
  }
}