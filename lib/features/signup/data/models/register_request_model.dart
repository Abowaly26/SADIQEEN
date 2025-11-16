import 'package:json_annotation/json_annotation.dart';

part 'register_request_model.g.dart';

@JsonSerializable()
class RegisterRequestModel {
  @JsonKey(name: "first_name")
  final String firstName;

  @JsonKey(name: "last_name")
  final String lastName;

  @JsonKey(name: "country_code")
  final String countryCode;

  final String phone;

  final String password;

  @JsonKey(name: "password_confirmation")
  final String passwordConfirmation;

  RegisterRequestModel({
    required this.firstName,
    required this.lastName,
    required this.countryCode,
    required this.phone,
    required this.password,
    required this.passwordConfirmation,
  });

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestModelFromJson(json);

  
  Map<String, dynamic> toJson() => _$RegisterRequestModelToJson(this);
}
