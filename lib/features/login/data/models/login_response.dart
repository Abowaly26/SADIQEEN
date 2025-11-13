import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginResponse {
  final LoginData data;
  final String message;
  final String type;
  final int status;
  @JsonKey(name: 'showToast')
  final bool showToast;

  LoginResponse({
    required this.data,
    required this.message,
    required this.type,
    required this.status,
    required this.showToast,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LoginData {
  final UserModel user;
  final String token;
  @JsonKey(name: 'token_type')
  final String tokenType;

  LoginData({required this.user, required this.token, required this.tokenType});

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserModel {
  final int id;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'country_code')
  final String countryCode;
  final String phone;
  @JsonKey(name: 'provider_status')
  final String providerStatus;
  final String type;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.countryCode,
    required this.phone,
    required this.providerStatus,
    required this.type,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
