import 'package:dio/dio.dart';
import 'package:sigede_flutter/core/utils/dio_client.dart';
import 'package:sigede_flutter/screens/auth/data/models/capturista.dart';

abstract class CapturistaRemoteDataSource {
  Future<List<Capturista>> getAllCapturistas({
    required String role,
    required int institutionId,
  });
  Future<Capturista> getUser(String id);
  Future<Capturista> createUser(Capturista capturista);
  Future<Capturista> updateUser(String id, Capturista capturista);
  Future<void> deleteUser(String id);
}

class CapturistaRemoteDataSourceImpl implements CapturistaRemoteDataSource {
  final DioClient dioClient;

  CapturistaRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<Capturista>> getAllCapturistas({
    required String role,
    required int institutionId,
  }) async {
    try {
      final response = await dioClient.dio.post(
        '/users/get-all-by-institution-rolename?page=0&size=10&sort=name,desc',
        data: {
          "role": role,
          "institutionId": institutionId,
        },
      );

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        final List<dynamic> data = response.data['content'];
        return data.map((json) => Capturista.fromJson(json)).toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } on DioException catch (dioError) {
      if (dioError.response != null) {
        final statusCode = dioError.response?.statusCode;
        final errorMessage = dioError.response?.data?['message'] ?? 'Unknown error';

        switch (statusCode) {
          case 400:
            throw Exception('Bad Request: $errorMessage');
          case 401:
            throw Exception('Unauthorized: Invalid credentials.');
          case 403:
            throw Exception('Forbidden: Access denied.');
          case 500:
            throw Exception('Internal Server Error: $errorMessage');
          default:
            throw Exception('Request failed: $statusCode - $errorMessage');
        }
      } else {
        throw Exception('Network error: ${dioError.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<Capturista> getUser(String id) async {
    final response = await dioClient.dio.get('/users/$id');
    return Capturista.fromJson(response.data);
  }

  @override
  Future<Capturista> createUser(Capturista capturista) async {
    final response = await dioClient.dio.post('/users', data: capturista.toJson());
    return Capturista.fromJson(response.data);
  }

  @override
  Future<Capturista> updateUser(String id, Capturista user) async {
    final response = await dioClient.dio.put('/users/$id', data: user.toJson());
    return Capturista.fromJson(response.data);
  }

  @override
  Future<void> deleteUser(String id) async {
    await dioClient.dio.delete('/users/$id');
  }
}
