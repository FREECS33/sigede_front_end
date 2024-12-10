import 'package:sigede_flutter/core/utils/dio_client.dart';
import 'package:sigede_flutter/modules/admin/data/models/capturista_model.dart';

abstract class CapturistRemoteDataSource {
  Future<List<CapturistaModel>> getCapturistasByInstitution(int institutionId);

  Future<void> updateCapturistaStatus(String email, String status);
}

class CapturistRemoteDataSourceImpl implements CapturistRemoteDataSource {
  final DioClient dioClient;

  CapturistRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<CapturistaModel>> getCapturistasByInstitution(int institutionId) async {
    try {
      final response = await dioClient.dio.get('/api/users/capturists/$institutionId');
      if (response.statusCode == 200) {
        final data = response.data as List;
        return data.map((json) => CapturistaModel.fromJson(json)).toList();
      } else {
        throw Exception('Error al obtener capturistas: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Error en getCapturistasByInstitution: $e');
    }
  }

  @override
  Future<void> updateCapturistaStatus(String email, String status) async {
    try {
      final response = await dioClient.dio.post('/api/users/update-status', data: {
        "email": email,
        "status": status,
      });
      if (response.statusCode != 200) {
        throw Exception('Error al actualizar el estado: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Error en updateCapturistaStatus: $e');
    }
  }
}
