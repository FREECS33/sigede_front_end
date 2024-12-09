import 'package:sigede_flutter/core/utils/dio_client.dart';
import 'package:sigede_flutter/modules/capturista/data/models/credential_model.dart';

abstract class CredentialRemoteDataSource {
  Future<List<CredentialModel>> getAllCredentials({
    required int institutionId
  });

  Future<CredentialModel> getCredential({
    required int credentialId,
  });

  Future<dynamic> createCredential({
    required String fullname,
    required String userPhoto,
    required String expirationDate,
    required int fkInstitution,
  });

  Future<dynamic> updateCredential({
    required int credentialId,
    required String fullname,
    required String userPhoto,
    required String expirationDate,
  });

  Future<dynamic> deleteCredential({
    required int credentialId,
  });
}

class CredentialRemoteDataSourceImpl implements CredentialRemoteDataSource {
  final DioClient dioClient;

  CredentialRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<CredentialModel>> getAllCredentials({
    required int institutionId
  }) async {
    final response = await dioClient.dio.post(
      '/api/credentials/get-all-by-institution?page=0&size=10&sort=fullname,desc',
      data: {
        "institutionId": institutionId,
        "fullName":""
      },
    );
    final List<dynamic> data = response.data['data']['content'] ?? [];
    return data.map((json) => CredentialModel.fromJson(json)).toList();
  }

  @override
  Future<CredentialModel> getCredential({
    required int credentialId,
  }) async {
    final response = await dioClient.dio.get(
      '/api/credentials/get-credential/$credentialId',
    );
    print('LLEGO: ${response.data['data']}');
    return CredentialModel.fromJson(response.data['data']);
  }

  @override
  Future<dynamic> createCredential({
    required String fullname,
    required String userPhoto,
    required String expirationDate,
    required int fkInstitution,
  }) async {
    final response = await dioClient.dio.post(
      '/api/credentials/register',
      data: {
        "fullname": fullname,
        "userPhoto": userPhoto,
        "expirationDate": expirationDate,
        "fkInstitution": fkInstitution,
      },
    );
    return response;
  }

  @override
  Future<dynamic> updateCredential({
    required int credentialId,
    required String fullname,
    required String userPhoto,
    required String expirationDate,
  }) async {
    final response = await dioClient.dio.put(
      '/api/credentials/update',
      data: {
        "credentialId": credentialId,
        "fullname": fullname,
        "userPhoto": userPhoto,
        "expirationDate": expirationDate,
      },
    );
    print("LLEGO: $response");
    return response;
  }

  @override
  Future<dynamic> deleteCredential({
    required int credentialId,
  }) async {
    final response = await dioClient.dio.delete(
      '/api/credentials/delete/$credentialId',
    );
    print("CREDENCIAL ELIMINADA: $response");
    return response;
  }
}
