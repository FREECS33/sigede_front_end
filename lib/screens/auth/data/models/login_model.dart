import 'package:sigede_flutter/screens/auth/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity{
  LoginModel({
    required super.userEmail,
    required super.password,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      userEmail: json['userEmail'],
      password: json['password'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
      'password': password,
    };
  }
}