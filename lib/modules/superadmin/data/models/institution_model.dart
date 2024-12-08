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

class PageModel extends PageEntity{
  PageModel({
    required super.name, required super.page, required super.size
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'page': page,
      'size': size,
    };
  }
}

class AddInstitutionModel extends AddInstitutionEntity{
  AddInstitutionModel({
    required super.institutionName,
    required super.institutionAddress,
    required super.institutionEmail,
    required super.institutionPhone,
    required super.logo,    
  });

  Map<String, dynamic> toJson() {
    return {
      'institutionName': institutionName,
      'institutionAddress': institutionAddress,
      'institutionEmail': institutionEmail,
      'institutionPhone': institutionPhone,
      'logo': logo,
    };
  }
}

class ResponseAddInstitutionModel extends ResponseAddInstitutionEntity{
  ResponseAddInstitutionModel({
    required super.id,    
    required super.name,
    required super.emailContact,
    required super.logo,
  });

  factory ResponseAddInstitutionModel.fromJson(Map<String, dynamic> json) {
    return ResponseAddInstitutionModel(
      id: json['id'], 
      name: json ['name'],
      emailContact: json ['email_contact'],
      logo: json ['logo'],
    );
  }
}