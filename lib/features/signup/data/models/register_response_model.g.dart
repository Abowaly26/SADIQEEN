// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponseModel _$RegisterResponseModelFromJson(
  Map<String, dynamic> json,
) => RegisterResponseModel(
  data: RegisterData.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String,
  type: json['type'] as String,
  status: (json['status'] as num).toInt(),
  showToast: json['showToast'] as bool,
);

Map<String, dynamic> _$RegisterResponseModelToJson(
  RegisterResponseModel instance,
) => <String, dynamic>{
  'data': instance.data,
  'message': instance.message,
  'type': instance.type,
  'status': instance.status,
  'showToast': instance.showToast,
};

RegisterData _$RegisterDataFromJson(Map<String, dynamic> json) => RegisterData(
  user: RegisterUser.fromJson(json['user'] as Map<String, dynamic>),
  otpExpiresAt: json['otp_expires_at'] as String,
);

Map<String, dynamic> _$RegisterDataToJson(RegisterData instance) =>
    <String, dynamic>{
      'user': instance.user,
      'otp_expires_at': instance.otpExpiresAt,
    };

RegisterUser _$RegisterUserFromJson(Map<String, dynamic> json) => RegisterUser(
  id: (json['id'] as num).toInt(),
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  countryCode: json['country_code'] as String,
  phone: json['phone'] as String,
  providerStatus: json['provider_status'] as String,
  type: json['type'] as String,
);

Map<String, dynamic> _$RegisterUserToJson(RegisterUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'country_code': instance.countryCode,
      'phone': instance.phone,
      'provider_status': instance.providerStatus,
      'type': instance.type,
    };
