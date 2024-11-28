import 'package:sigede_flutter/modules/superadmin/domain/entities/institutions_entity.dart';

class InstitutionsModel extends InstitutionsEntity{
  // ignore: use_super_parameters
  InstitutionsModel({required data}) : super(data: data);
    factory InstitutionsModel.fromJson(Map<String, dynamic> json) {
    return InstitutionsModel(
      data: (json['data'] as List)
          .map((item) => InstitutionsModel.fromJson(item))
          .toList(),
    );
  }
}