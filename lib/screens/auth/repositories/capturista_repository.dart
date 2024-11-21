import 'package:sigede_flutter/screens/auth/datasource/user_remote_data_source.dart';
import 'package:sigede_flutter/screens/auth/models/capturista.dart';

abstract class CapturistaRepository {
  Future<List<Capturista>> getAllCapturistas();
  Future<Capturista> getUser(String id);
  Future<Capturista> createUser(Capturista capturista);
  Future<Capturista> updateUser(String id, Capturista capturista);
  Future<void> deleteUser(String id);
  Future<void> updateCapturista(Capturista capturista);
}

class UserRepositoryImpl implements CapturistaRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Capturista>> getAllCapturistas() async {
    return await remoteDataSource.getAllCapturistas();
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

  @override
  Future<void> updateCapturista(Capturista capturista) async {
    await remoteDataSource.updateCapturista(capturista);
  }

  @override
  Future<Capturista> getUserById(String id) async {
    return await remoteDataSource.getUser(id);
  }

}
