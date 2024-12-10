import 'package:dio/dio.dart';
import 'package:sigede_flutter/core/utils/dio_client.dart';
import 'package:sigede_flutter/modules/admin/data/models/capturista_model.dart';
import 'package:sigede_flutter/modules/admin/data/models/institution_capturer_model.dart';
import 'package:sigede_flutter/modules/superadmin/data/models/admin_model.dart';

abstract class CapturistRemoteDataSource {
  Future<List<CapturistaModel>> getCapturistasByInstitution(int institutionId);

  Future<void> updateCapturistaStatus(String email, String status);

  Future<List<CapturistaModel>> getCapturerByName(FilterCapturerModel model);

  Future<InstitutionCapturerModel> getOneInstitution(int institutionId);
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
  @override
  Future<List<CapturistaModel>> getCapturerByName(FilterCapturerModel model) async {
    try{
      final response = await dioClient.dio.post(
        '/api/capturists/get-capturists-by-name-and-institution',
        data: model.toJson()
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        // Verificar si 'data' es una lista antes de mapear
        if (response.data['data']['content'] is List) {
          return (response.data['data']['content'] as List)
              .map((json) => CapturistaModel.fromJson(json))
              .toList();
        } else {
          throw Exception('Expected a list in response.data["data"]');
        }
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (dioError) {
      if (dioError.response != null) {
        switch (dioError.response?.statusCode) {
          case 400:
            throw Exception("Bad Request: ${dioError.response?.data}");
          case 401:
            throw Exception("Unauthorized: ${dioError.response?.data}");
          case 403:
            throw Exception("Forbidden: ${dioError.response?.data}");
          case 500:
            throw Exception("Internal Server Error: ${dioError.response?.data}");
          default:
            throw Exception("Unhandled Error: ${dioError.response?.data}");
        }
      } else {
        throw Exception('Network error: ${dioError.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
  @override
  Future<InstitutionCapturerModel> getOneInstitution(int institutionId) async {
    try {
      final response = await dioClient.dio.get('/api/institutions/$institutionId');
      if (response.statusCode == 200) {        
        return InstitutionCapturerModel.fromJson(response.data['data']);
      } else {
        throw Exception('Error al obtener capturistas: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Error en getCapturistasByInstitution: $e');
    }
  }
}
