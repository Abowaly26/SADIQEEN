// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiErrorModel _$ApiErrorModelFromJson(Map<String, dynamic> json) =>
    ApiErrorModel(
      data: json['data'],
      message: json['message'] as String,
      type: json['type'] as String,
      status: (json['status'] as num?)?.toInt(),
      showToast: json['showToast'] as bool,
    );

Map<String, dynamic> _$ApiErrorModelToJson(ApiErrorModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'type': instance.type,
      'status': instance.status,
      'showToast': instance.showToast,
    };
