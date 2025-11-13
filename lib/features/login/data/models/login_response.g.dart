// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      data: LoginData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String,
      type: json['type'] as String,
      status: (json['status'] as num).toInt(),
      showToast: json['showToast'] as bool,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
      'message': instance.message,
      'type': instance.type,
      'status': instance.status,
      'showToast': instance.showToast,
    };

LoginData _$LoginDataFromJson(Map<String, dynamic> json) => LoginData(
  user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
  token: json['token'] as String,
  tokenType: json['token_type'] as String,
);

Map<String, dynamic> _$LoginDataToJson(LoginData instance) => <String, dynamic>{
  'user': instance.user.toJson(),
  'token': instance.token,
  'token_type': instance.tokenType,
};

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: (json['id'] as num).toInt(),
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  countryCode: json['country_code'] as String,
  phone: json['phone'] as String,
  providerStatus: json['provider_status'] as String,
  type: json['type'] as String,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'country_code': instance.countryCode,
  'phone': instance.phone,
  'provider_status': instance.providerStatus,
  'type': instance.type,
};
