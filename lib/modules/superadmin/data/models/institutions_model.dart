import 'package:sigede_flutter/modules/superadmin/domain/entities/institutions_entity.dart';

class InstitutionsModel extends InstitutionsEntity{
  InstitutionsModel({required List<String> data}) : super(data: data);
  factory InstitutionsModel.fromJson(Map<String,dynamic>json){
    return InstitutionsModel(
      data: json['data'],
    );
  }
}