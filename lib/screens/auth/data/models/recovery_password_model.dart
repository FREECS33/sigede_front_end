import 'package:sigede_flutter/screens/auth/domain/entities/recovery_password_entity.dart';

class RecoveryPasswordModel extends RecoveryPasswordEntity{
  RecoveryPasswordModel({
    super.error, super.userEmail
  });

  factory RecoveryPasswordModel.fromJson(Map<String, dynamic> json) {
    return RecoveryPasswordModel(
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
    };
  }
}