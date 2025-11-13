import 'package:json_annotation/json_annotation.dart';

part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  final Object? data;
  final String message;
  final String type;
  final int? status;
  final bool showToast;

  ApiErrorModel({
    this.data,
    required this.message,
    required this.type,
    required this.status,
    required this.showToast,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);
}
