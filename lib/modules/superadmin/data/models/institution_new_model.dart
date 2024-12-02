import 'package:sigede_flutter/modules/superadmin/domain/entities/institution_new_entity.dart';

class InstitutionNewModel extends InstitutionNewEntity{
  InstitutionNewModel({
    int? id,
    required super.name,
    required super.address,
    required super.emailContact,
    required super.phone,
    required super.logo,
  });

  factory InstitutionNewModel.fromJson(Map<String, dynamic> json) {
    return InstitutionNewModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      emailContact: json['emailContact'],
      phone: json['phone'],
      logo: json['logo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'emailContact': emailContact,
      'phone': phone,
      'logo': logo,
    };
  }
}