import 'package:sigede_flutter/screens/auth/domain/entities/code_confirmation_entity.dart';

class CodeConfirmationModel extends CodeConfirmationEntity{
  CodeConfirmationModel({
    super.code,
    super.userId,
    super.error,
    super.data,
  });

  factory CodeConfirmationModel.fromJson(Map<String, dynamic> json) {
    return CodeConfirmationModel(
      error: json['error'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'userId': userId,
    };
  }
}