import 'package:sigede_flutter/modules/superadmin/data/models/institution_model.dart';
import 'package:sigede_flutter/modules/superadmin/data/repositories/institution_repository.dart';

class GetAllInstitutions {
  final InstitutionRepository repository;

  GetAllInstitutions({required this.repository});

  Future<List<InstitutionModel>> call() async {
    return await repository.getAllInstitutions();
  }
}