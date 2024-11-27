import 'package:sigede_flutter/modules/superadmin/domain/entities/institutions_entity.dart';

class InstitutionsModel extends InstitutionsEntity{
  InstitutionsModel({required super.name, required super.logo, required super.email_contact});
  factory InstitutionsModel.fromJson(Map<String,dynamic>json){
    return InstitutionsModel(
      name: json['name'],
      logo: json['logo'],
      email_contact: json['email_contact'],
    );
  }
}