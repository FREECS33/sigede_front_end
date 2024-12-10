import 'package:sigede_flutter/modules/admin/domain/entities/institution_info_entity.dart';

class InstitutionCapturerModel extends InstitutionInfoEntity{  
  const InstitutionCapturerModel({
    required super.name,
    required super.logo,
  });

  factory InstitutionCapturerModel.fromJson(Map<String, dynamic> json) {
    return InstitutionCapturerModel(
      name: json['name'],
      logo: json['logo'],
    );
  }
}