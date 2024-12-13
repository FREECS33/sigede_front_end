import 'package:sigede_flutter/modules/admin/data/models/capturista_model.dart';
import 'package:sigede_flutter/modules/admin/data/repositories/credentials_institution.dart';

class GetAllCredentials {
  final CredentialsInstitutionRepository repository;

  GetAllCredentials({required this.repository});

  Future<List<ResponseCredentialInstitutionModel>> call(int userAccountId)async {
    return await repository.getCredentialsByInstitution(userAccountId);
  }
}