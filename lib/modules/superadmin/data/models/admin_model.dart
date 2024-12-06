import 'package:sigede_flutter/modules/superadmin/domain/entities/admin_entity.dart';

class AdminModel extends AdminEntity {
  AdminModel({
    required super.userId,
    required super.email,
    required super.name,
    required super.status,    
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      userId: json['userId'],   
      email: json['email'],
      name: json['name'],
      status: json['status'],    
    );
  }
}

class RequestAdminModel extends RequestAdminEntity {
  RequestAdminModel({
    required super.role,
    required super.institutionId,    
  });

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'institutionId': institutionId,
    };
  }
}