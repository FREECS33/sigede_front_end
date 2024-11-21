import 'package:sigede_flutter/screens/auth/datasource/user_remote_data_source.dart';
import 'package:sigede_flutter/screens/auth/models/capturista.dart';

abstract class CapturistaRepository {
  Future<List<Capturista>> getAllUsers();
  Future<Capturista> getUser(String id);
  Future<Capturista> createUser(Capturista capturista);
  Future<Capturista> updateUser(String id, Capturista capturista);
  Future<void> deleteUser(String id);
}

class UserRepositoryImpl implements CapturistaRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Capturista>> getAllUsers() async {
    return await remoteDataSource.getAllUsers();
  }

  @override
  Future<Capturista> getUser(String id) async {
    return await remoteDataSource.getUser(id);
  }

  @override
  Future<Capturista> createUser(Capturista capturista) async {
    return await remoteDataSource.createUser(capturista);
  }

  @override
  Future<Capturista> updateUser(String id, Capturista capturista)async {
    return await remoteDataSource.updateUser(id, capturista);
  }

  @override
  Future<void> deleteUser(String id) async {
    await remoteDataSource.deleteUser(id);
  }
}
