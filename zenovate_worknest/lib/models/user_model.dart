import 'package:flutter/material.dart';

enum UserRole { admin, manager, employee, intern }
enum UserStatus { active, inactive, onLeave }

class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String department;
  final DateTime joinDate;
  final UserRole role;
  final UserStatus status;
  final String? profileImage;
  final Map<String, dynamic>? additionalInfo;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.department,
    required this.joinDate,
    required this.role,
    required this.status,
    this.profileImage,
    this.additionalInfo,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      department: json['department'],
      joinDate: DateTime.parse(json['joinDate']),
      role: UserRole.values.firstWhere((e) => e.toString() == json['role']),
      status: UserStatus.values.firstWhere((e) => e.toString() == json['status']),
      profileImage: json['profileImage'],
      additionalInfo: json['additionalInfo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'department': department,
      'joinDate': joinDate.toIso8601String(),
      'role': role.toString(),
      'status': status.toString(),
      'profileImage': profileImage,
      'additionalInfo': additionalInfo,
    };
  }
} 