import 'package:equatable/equatable.dart';

enum Role { user, admin }

class User extends Equatable {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String name;
  final String dateOfBirth;
  final String phoneNumber;
  final Role role;

  const User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.role,
  });

  User copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? name,
    String? dateOfBirth,
    String? phoneNumber,
    Role? role,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      name: json['name'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      phoneNumber: json['phoneNumber'] as String,
      role: Role.values.firstWhere(
        (e) => e.toString().split('.').last == (json['role'] as String),
      ),
    );
  }

  @override
  List<Object> get props => [
    id,
    email,
    firstName,
    lastName,
    name,
    dateOfBirth,
    phoneNumber,
    role,
  ];
}
