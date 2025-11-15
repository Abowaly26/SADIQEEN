import 'package:json_annotation/json_annotation.dart';

part 'meta_model.g.dart';

@JsonSerializable()
class MetaModel {
  @JsonKey(name: "current_page")
  final int currentPage;

  final int from;

  @JsonKey(name: "last_page")
  final int lastPage;

  MetaModel({
    required this.currentPage,
    required this.from,
    required this.lastPage,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) =>
      _$MetaModelFromJson(json);

  Map<String, dynamic> toJson() => _$MetaModelToJson(this);
}
