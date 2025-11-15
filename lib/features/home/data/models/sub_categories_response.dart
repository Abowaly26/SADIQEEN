import 'package:json_annotation/json_annotation.dart';
import 'package:sadiqeen/features/home/data/models/meta_model.dart';
import 'sub_category_model.dart';
import 'pagination_links.dart';


part 'sub_categories_response.g.dart';

@JsonSerializable()
class SubCategoriesResponse {
  final List<SubCategory> data;
  final PaginationLinks? links;
  final MetaModel? meta;
  final String message;
  final int code;
  final String type;

  SubCategoriesResponse({
    required this.data,
    this.links,
    this.meta,
    required this.message,
    required this.code,
    required this.type,
  });

  factory SubCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$SubCategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SubCategoriesResponseToJson(this);
}
