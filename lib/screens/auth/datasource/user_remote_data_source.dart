import 'package:sigede_flutter/kernel/utils/dio_capturista.dart';
import 'package:sigede_flutter/screens/auth/models/capturista.dart';

abstract class UserRemoteDataSource {
  Future<List<Capturista>> getAllCapturistas();
  Future<Capturista> getUser(String id);
  Future<Capturista> createUser(Capturista capturista);
  Future<Capturista> updateUser(String id, Capturista capturista);
  Future<void> deleteUser(String id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final DioClient dioClient;

  UserRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<Capturista>> getAllCapturistas() async {
    final response = await dioClient.get('/users');
    return (response.data as List).map((json) => Capturista.fromJson(json)).toList();
  }

  @override
  Future<Capturista> getUser(String id) async {
    final response = await dioClient.get('/users/$id');
    return Capturista.fromJson(response.data);
  }

  @override
  Future<Capturista> createUser(Capturista capturista) async {
    final response = await dioClient.post('/users', data: capturista.toJson());
    return Capturista.fromJson(response.data);
  }

  @override
  Future<Capturista> updateUser(String id, Capturista user) async {
    final response = await dioClient.put('/users/$id', data: user.toJson());
    return Capturista.fromJson(response.data);
  }

  @override
  Future<void> deleteUser(String id) async {
    await dioClient.delete('/users/$id');
  }
}