import 'package:sigede_flutter/screens/auth/data/datasources/capturista_remote_data_source.dart';
import 'package:sigede_flutter/screens/auth/data/models/capturista.dart';

abstract class CapturistaRepository {
  Future<List<Capturista>> getAllCapturistas({
    required String role,
    required int institutionId,
  });
  Future<Capturista> getUser(String id);
  Future<Capturista> createUser(Capturista capturista);
  Future<Capturista> updateUser(String id, Capturista capturista);
  Future<void> deleteUser(String id);
}

class UserRepositoryImpl implements CapturistaRepository {
  final CapturistaRemoteDataSource capturistaRemoteDataSource;

  UserRepositoryImpl({required this.capturistaRemoteDataSource});

  @override
  Future<List<Capturista>> getAllCapturistas({
    required String role,
    required int institutionId,
  }) async {
    return await capturistaRemoteDataSource.getAllCapturistas(
      role: role,
      institutionId: institutionId,
    );
  }

  @override
  Future<Capturista> getUser(String id) async {
    return await capturistaRemoteDataSource.getUser(id);
  }

  @override
  Future<Capturista> createUser(Capturista capturista) async {
    return await capturistaRemoteDataSource.createUser(capturista);
  }

  @override
  Future<Capturista> updateUser(String id, Capturista capturista)async {
    return await capturistaRemoteDataSource.updateUser(id, capturista);
  }

  @override
  Future<void> deleteUser(String id) async {
    await capturistaRemoteDataSource.deleteUser(id);
  }
}
