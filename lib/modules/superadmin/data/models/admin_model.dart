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

class FilterAdminModel extends FilterAdminEntity {
  FilterAdminModel({
    required super.institutionId,
    required super.name,
    required super.page,
    required super.size,    
  });

  Map<String, dynamic> toJson() {
    return {
      'institutionId': institutionId,
      'name': name,
      'page': page,
      'size': size,
    };
  }
}

class AddAdminModel extends AddAdminEntity {
  AddAdminModel({
    required super.email,
    required super.name,
    required super.fkInstitution,    
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'fkInstitution': fkInstitution,
    };
  }
}

class ResponseAddAdminModel extends ResponseAddAdminEntity {
  ResponseAddAdminModel({
    required super.status,    
  });

  factory ResponseAddAdminModel.fromJson(Map<String, dynamic> json) {
    return ResponseAddAdminModel(
      status: json['status'],
    );
  }
}