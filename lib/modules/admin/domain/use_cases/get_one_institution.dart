import 'package:sigede_flutter/modules/admin/data/models/institution_capturer_model.dart';
import 'package:sigede_flutter/modules/admin/data/repositories/capturer_repository.dart';

class GetOneInstitution {
  final CapturerRepository repository;

  GetOneInstitution({required this.repository});

  Future<InstitutionCapturerModel> call(int institutionId) async {
    return await repository.getOneInstitution(institutionId);
  }
}