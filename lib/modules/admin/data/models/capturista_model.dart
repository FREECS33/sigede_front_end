import 'package:sigede_flutter/modules/admin/domain/entities/capturista_entity.dart';

class CapturistaModel extends CapturistaEntity {
  const CapturistaModel({
    required super.userAccountId,
    required super.name,
    required super.status,
    required super.email,
  });

  factory CapturistaModel.fromJson(Map<String, dynamic> json) {
    return CapturistaModel(
      userAccountId: json['userAccountId'],
      name: json['name'],
      status: json['status'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userAccountId": userAccountId,
      "name": name,
      "status": status,
      "email": email,
    };
  }
}
