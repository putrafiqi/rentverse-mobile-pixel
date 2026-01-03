import 'package:equatable/equatable.dart';

enum Role { user, admin }

class User extends Equatable {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String name;
  final Role role;

  final DateTime? dateOfBirth;
  final String? phoneNumber;
  final String? profilePicture;

  const User({
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

  User copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? name,
    Role? role,
    DateTime? dateOfBirth,
    String? phoneNumber,
    String? profilePicture,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      name: name ?? this.name,
      role: role ?? this.role,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
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
