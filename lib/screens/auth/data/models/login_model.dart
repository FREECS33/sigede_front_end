import 'package:sigede_flutter/screens/auth/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity{
  LoginModel({
    super.token, 
    required super.email,
    super.password,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email: json['email'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}