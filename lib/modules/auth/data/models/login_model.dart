import 'package:sigede_flutter/modules/auth/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity{
  LoginModel({    
    required super.email,
    required super.password,
  });  

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class ResponseLoginModel extends ResponseLoginEntity {
  ResponseLoginModel({
    required super.token,
    required super.email,
    required super.userId,
    required super.institutionId,    
  });

  factory ResponseLoginModel.fromJson(Map<String, dynamic> json) {
    return ResponseLoginModel(
      token: json['token'],
      email: json['email'],
      userId: json['userId'],
      institutionId: json['institutionId'],
    );
  }
}