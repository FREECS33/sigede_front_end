import 'package:sigede_flutter/core/utils/dio_client.dart';
import 'package:sigede_flutter/modules/admin/data/models/capturista.dart';

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
    final response = await dioClient.dio.post(
      '/api/users/get-all-by-institution-rolename?page=0&size=10&sort=name,desc',
      data: {
        "role": role,
        "institutionId": institutionId,
      },
    );
    print('LLEGO: ${response}');
    final List<dynamic> data = response.data['content'] ?? [];
    return data.map((json) => Capturista.fromJson(json)).toList();
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
