import 'package:json_annotation/json_annotation.dart';

part 'categories_response_model.g.dart';

@JsonSerializable()
class CategoriesResponse {
  final List<Category> data;
  final String message;
  final String type;
  final int status;
  final bool showToast;

  CategoriesResponse({
    required this.data,
    required this.message,
    required this.type,
    required this.status,
    required this.showToast,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesResponseToJson(this);
}

@JsonSerializable()
class Category {
  final int id;
  final String icon;
  final String name;

  Category({
    required this.id,
    required this.icon,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
