import 'package:sigede_flutter/modules/superadmin/domain/entities/institution_entity.dart';

class InstitutionModel extends InstitutionEntity{

  InstitutionModel({
    required super.institutionId,
    required super.name,
    required super.emailContact,
    required super.logo,    
  });

  factory InstitutionModel.fromJson(Map<String, dynamic> json) {
    return InstitutionModel(
      institutionId: json['institutionId'],
      name: json['name'],
      emailContact: json['email_contact'],
      logo: json['logo'],
    );
  }
}