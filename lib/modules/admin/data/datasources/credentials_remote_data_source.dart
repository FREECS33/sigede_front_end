import 'package:sigede_flutter/core/utils/dio_client.dart';
import 'package:sigede_flutter/modules/admin/data/models/capturista_model.dart';

abstract class CredentialsRemoteDataSource {
  Future<List<ResponseCredentialInstitutionModel>> getCredentialsByInstitution(int userAccountId);
}

class CredentialsRemoteDataSourceImpl implements CredentialsRemoteDataSource {
  final DioClient dioClient;

  CredentialsRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<ResponseCredentialInstitutionModel>> getCredentialsByInstitution(int userAccountId) async {
    try {
      final response = await dioClient.dio.get(
        '/api/credentials/capturist/$userAccountId',        
      );
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        final data = response.data as List;
        return data.map((json) => ResponseCredentialInstitutionModel.fromJson(json)).toList();
      } else {
        throw Exception('Error al obtener credenciales: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Error en getCredentialsByInstitution: $e');
    }
  }
}