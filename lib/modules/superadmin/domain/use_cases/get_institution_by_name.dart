import 'package:sigede_flutter/modules/superadmin/data/models/institution_model.dart';
import 'package:sigede_flutter/modules/superadmin/data/repositories/institution_repository.dart';

class GetInstitutionByName {
  final InstitutionRepository repository;

  GetInstitutionByName({required this.repository});

  Future<List<InstitutionModel>> call(PageModel model) async {
    return await repository.getInstitutionByName(model);
  }
}