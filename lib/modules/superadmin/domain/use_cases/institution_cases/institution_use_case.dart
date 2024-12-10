import 'package:sigede_flutter/modules/superadmin/data/models/institution_model.dart';
import 'package:sigede_flutter/modules/superadmin/data/repositories/institution_repository.dart';

class GetAllInstitutions {
  final InstitutionRepository repository;

  GetAllInstitutions({required this.repository});

  Future<List<InstitutionModel>> call() async {
    return await repository.getAllInstitutions();
  }
}

class GetInstitutionByName {
  final InstitutionRepository repository;

  GetInstitutionByName({required this.repository});

  Future<List<InstitutionModel>> call(PageModel model) async {
    return await repository.getInstitutionByName(model);
  }
}

class AddInstitution {
  final InstitutionRepository repository;

  AddInstitution({required this.repository});

  Future<ResponseAddInstitutionModel> call(AddInstitutionModel model) async {
    return await repository.addInstitution(model);
  }
}