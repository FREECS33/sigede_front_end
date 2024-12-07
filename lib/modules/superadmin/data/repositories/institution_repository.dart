import 'package:sigede_flutter/modules/superadmin/data/datasources/institution_data_source.dart';
import 'package:sigede_flutter/modules/superadmin/data/models/institution_model.dart';

abstract class InstitutionRepository {
  Future<List<InstitutionModel>> getAllInstitutions();
  Future<List<InstitutionModel>> getInstitutionByName(PageModel model);
  Future<ResponseAddInstitutionModel> addInstitution(AddInstitutionModel model);
}

class InstitutionRepositoryImpl implements InstitutionRepository {
  final InstitutionDataSource institutionDataSource;

  InstitutionRepositoryImpl({required this.institutionDataSource});

  @override
  Future<List<InstitutionModel>> getAllInstitutions() async {
    return institutionDataSource.getAllInstitutions();
  }

  @override
  Future<List<InstitutionModel>> getInstitutionByName(PageModel model) async {
    return institutionDataSource.getInstitutionByName(model);
  }

  @override
  Future<ResponseAddInstitutionModel> addInstitution(AddInstitutionModel model) async {
    return institutionDataSource.addInstitution(model);
  }
}