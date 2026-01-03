import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../repositories/repositories.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String name;
  final DateTime? dateOfBirth;
  @JsonKey(name: 'phone')
  final String? phoneNumber;
  final String role;
  final String? profilePicture;

  const UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.role,
    this.dateOfBirth,
    this.phoneNumber,
    this.profilePicture,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  User toEntity() {
    return User(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      name: name,
      role: role.toUpperCase() == 'ADMIN' ? Role.admin : Role.user,
      dateOfBirth: dateOfBirth,
      phoneNumber: phoneNumber,
      profilePicture: profilePicture,
    );
  }

  @override
  List<Object?> get props => [
    id,
    email,
    firstName,
    lastName,
    name,
    role,
    dateOfBirth,
    phoneNumber,
    profilePicture,
  ];
}
