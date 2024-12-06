import 'package:sigede_flutter/modules/superadmin/data/datasources/institution_data_source.dart';
import 'package:sigede_flutter/modules/superadmin/data/models/institution_model.dart';

abstract class InstitutionRepository {
  Future<List<InstitutionModel>> getAllInstitutions();
}

class InstitutionRepositoryImpl implements InstitutionRepository {
  final InstitutionDataSource institutionDataSource;

  InstitutionRepositoryImpl({required this.institutionDataSource});

  @override
  Future<List<InstitutionModel>> getAllInstitutions() async {
    return institutionDataSource.getAllInstitutions();
  }
}