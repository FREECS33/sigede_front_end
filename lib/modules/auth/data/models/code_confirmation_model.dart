import 'package:sigede_flutter/modules/auth/domain/entities/code_confirmation_entity.dart';

class CodeConfirmationModel extends CodeConfirmationEntity{
  CodeConfirmationModel({
    required super.code,
    required super.userEmail
    
  }); 

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'userEmail': userEmail,
    };
  }
}

class ResponseCodeConfirmationModel extends ResponseCodeConfirmationEntity {
  ResponseCodeConfirmationModel({
    required super.status,
    required super.message,
    required super.error,
    required super.data,
  });

  factory ResponseCodeConfirmationModel.fromJson(Map<String, dynamic> json) {
    return ResponseCodeConfirmationModel(
      status: json['status'],
      message: json['message'],
      error: json['error'],
      data: json['data'],
    );
  }
}