import 'package:sigede_flutter/modules/admin/data/datasources/credentials_remote_data_source.dart';
import 'package:sigede_flutter/modules/admin/data/models/capturista_model.dart';

abstract class CredentialsInstitutionRepository {
  Future<List<ResponseCredentialInstitutionModel>> getCredentialsByInstitution(int userAccountId);
}

class CredentialsInstitutionRepositoryImpl implements CredentialsInstitutionRepository{
  final CredentialsRemoteDataSource remoteDataSource;

  CredentialsInstitutionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ResponseCredentialInstitutionModel>> getCredentialsByInstitution(int userAccountId) {
    return remoteDataSource.getCredentialsByInstitution(userAccountId);
  }
}