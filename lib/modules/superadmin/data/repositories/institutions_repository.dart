import 'package:sigede_flutter/modules/superadmin/data/datasources/institutions_all_data_source.dart';
import 'package:sigede_flutter/modules/superadmin/data/models/institutions_model.dart';
import 'package:sigede_flutter/modules/superadmin/domain/entities/institutions_entity.dart';

abstract class InstitutionsRepository {
  Future<InstitutionsEntity> getAllInstitutions(InstitutionsModel model);
}

class InstitutionsRepositoryImpl implements InstitutionsRepository{
  final InstitutionsAllDataSource institutionsAllDataSource;

  InstitutionsRepositoryImpl({required this.institutionsAllDataSource});

  @override
  Future<InstitutionsEntity> getAllInstitutions(InstitutionsModel model)async{
    return await institutionsAllDataSource.getAllInstitutions(model);
  }
}