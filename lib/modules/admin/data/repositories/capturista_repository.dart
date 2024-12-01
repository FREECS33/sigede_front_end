import 'package:sigede_flutter/modules/admin/data/datasources/capturista_remote_data_source.dart';
import 'package:sigede_flutter/modules/admin/data/models/capturista.dart';
import 'package:sigede_flutter/modules/admin/data/models/simple_capturista.dart';

abstract class CapturistaRepository {
  Future<List<SimpleCapturista>> getAllCapturistas({
    required String role,
    required int institutionId,
  });
  Future<Capturista> getCapturista({
    required int userId
  });
  Future<Capturista> createUser(Capturista capturista);
  Future<Capturista> updateUser(String id, Capturista capturista);
  Future<void> deleteUser(String id);
}

class CapturistaRepositoryImpl implements CapturistaRepository {
  final CapturistaRemoteDataSource capturistaRemoteDataSource;

  CapturistaRepositoryImpl({required this.capturistaRemoteDataSource});

  @override
  Future<List<SimpleCapturista>> getAllCapturistas({
    required String role,
    required int institutionId,
  }) async {
    return await capturistaRemoteDataSource.getAllCapturistas(
      role: role,
      institutionId: institutionId,
    );
  }

  @override
  Future<Capturista> getCapturista({required int userId}) async {
    return await capturistaRemoteDataSource.getCapturista(userId:userId);
  }

  @override
  Future<Capturista> createUser(Capturista capturista) async {
    return await capturistaRemoteDataSource.createUser(capturista);
  }

  @override
  Future<Capturista> updateUser(String id, Capturista capturista) async {
    return await capturistaRemoteDataSource.updateUser(id, capturista);
  }

  @override
  Future<void> deleteUser(String id) async {
    await capturistaRemoteDataSource.deleteUser(id);
  }
}
