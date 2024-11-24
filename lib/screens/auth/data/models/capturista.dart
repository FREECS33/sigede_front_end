import 'package:sigede_flutter/screens/auth/domain/entities/capturista_entity.dart';

class Capturista extends CapturistaEntity{
  
  Capturista({
    required super.userId,
    required super.name,
    required super.email,
    });

  factory Capturista.fromJson(Map<String, dynamic> json) {
    return Capturista(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      //isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      //'isActive': isActive,
    };
  }
}
