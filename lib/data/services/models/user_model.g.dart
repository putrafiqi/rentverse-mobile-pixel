// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String,
  email: json['email'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  name: json['name'] as String,
  dateOfBirth: json['dateOfBirth'] as String,
  phoneNumber: json['phoneNumber'] as String,
  role: json['role'] as String,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'name': instance.name,
  'dateOfBirth': instance.dateOfBirth,
  'phoneNumber': instance.phoneNumber,
  'role': instance.role,
};
