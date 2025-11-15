// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_categories_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubCategoriesResponse _$SubCategoriesResponseFromJson(
  Map<String, dynamic> json,
) => SubCategoriesResponse(
  data: (json['data'] as List<dynamic>)
      .map((e) => SubCategory.fromJson(e as Map<String, dynamic>))
      .toList(),
  links: json['links'] == null
      ? null
      : PaginationLinks.fromJson(json['links'] as Map<String, dynamic>),
  meta: json['meta'] == null
      ? null
      : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
  message: json['message'] as String,
  code: (json['code'] as num).toInt(),
  type: json['type'] as String,
);

Map<String, dynamic> _$SubCategoriesResponseToJson(
  SubCategoriesResponse instance,
) => <String, dynamic>{
  'data': instance.data,
  'links': instance.links,
  'meta': instance.meta,
  'message': instance.message,
  'code': instance.code,
  'type': instance.type,
};
