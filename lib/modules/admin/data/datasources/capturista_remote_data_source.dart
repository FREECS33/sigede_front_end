import 'package:sigede_flutter/core/utils/dio_client.dart';
import 'package:sigede_flutter/modules/admin/data/models/capturista.dart';
import 'package:sigede_flutter/modules/admin/data/models/simple_capturista.dart';
import 'package:sigede_flutter/modules/admin/domain/use_cases/get_capturista.dart';

abstract class CapturistaRemoteDataSource {
  Future<List<SimpleCapturista>> getAllCapturistas({
    required String role,
    required int institutionId,
  });
  Future<Capturista> getCapturista({required int userId});
  Future<Capturista> createUser(Capturista capturista);
  Future<Capturista> updateUser(String id, Capturista capturista);
  Future<void> deleteUser(String id);
}

class CapturistaRemoteDataSourceImpl implements CapturistaRemoteDataSource {
  final DioClient dioClient;

  CapturistaRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<SimpleCapturista>> getAllCapturistas({
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
    final List<dynamic> data = response.data['data']['content'] ?? [];
    return data.map((json) => SimpleCapturista.fromJson(json)).toList();
  }

  @override
  Future<Capturista> getCapturista({required int userId}) async {
    final response = await dioClient.dio.post(
      '/api/users/get-account',
      data: {
        "userId":userId
      }
    );
    print('LLEGO: $response');
    return Capturista.fromJson(response.data);
  }

  @override
  Future<Capturista> createUser(Capturista capturista) async {
    final response = await dioClient.dio.post(
      '/api/users/create',
      data: capturista,
    );
    return Capturista.fromJson(response.data);
  }

  @override
  Future<Capturista> updateUser(String id, Capturista capturista) async {
    final response = await dioClient.dio.put(
      '/api/users/update/$id',
      data: capturista,
    );
    return Capturista.fromJson(response.data);
  }

  @override
  Future<void> deleteUser(String id) async {
    await dioClient.dio.delete(
      '/api/users/delete/$id',
    );
  }
}
