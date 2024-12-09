import 'package:sigede_flutter/modules/auth/domain/entities/reset_password_entity.dart';

class ResetPasswordModel extends ResetPasswordEntity {
  ResetPasswordModel({
    super.newPassword,
    super.userEmail,
    super.error,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordModel(
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'newPassword': newPassword,
      'userEmail': userEmail,
    };
  }
}