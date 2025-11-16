import 'package:json_annotation/json_annotation.dart';

part 'register_response_model.g.dart';

@JsonSerializable()
class RegisterResponseModel {
  final RegisterData data;
  final String message;
  final String type;
  final int status;
  final bool showToast;

  RegisterResponseModel({
    required this.data,
    required this.message,
    required this.type,
    required this.status,
    required this.showToast,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseModelToJson(this);
}

@JsonSerializable()
class RegisterData {
  final RegisterUser user;

  @JsonKey(name: "otp_expires_at")
  final String otpExpiresAt;

  RegisterData({
    required this.user,
    required this.otpExpiresAt,
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) =>
      _$RegisterDataFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterDataToJson(this);
}

@JsonSerializable()
class RegisterUser {
  final int id;

  @JsonKey(name: "first_name")
  final String firstName;

  @JsonKey(name: "last_name")
  final String lastName;

  @JsonKey(name: "country_code")
  final String countryCode;

  final String phone;

  @JsonKey(name: "provider_status")
  final String providerStatus;

  final String type;

  RegisterUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.countryCode,
    required this.phone,
    required this.providerStatus,
    required this.type,
  });

  factory RegisterUser.fromJson(Map<String, dynamic> json) =>
      _$RegisterUserFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterUserToJson(this);
}
