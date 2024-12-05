import 'package:sigede_flutter/modules/superadmin/domain/entities/admins_entity.dart';

class AdminsModel extends AdminsEntity {
  AdminsModel({super.userId,super.name,super.email, super.role, super.fkInstitution});

  factory AdminsModel.fromJson(Map<String, dynamic> json) {
    return AdminsModel(
      userId: json['userId'],
      email: json['email'],
      name: json['name'],
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'role': role,
      'institutionId': fkInstitution,
    };
  }
}