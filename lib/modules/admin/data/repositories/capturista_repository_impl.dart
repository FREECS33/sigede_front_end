import 'package:sigede_flutter/modules/admin/data/datasources/capturist_remote_data_source.dart';
import 'package:sigede_flutter/modules/admin/data/repositories/capturist_repository.dart';
import 'package:sigede_flutter/modules/admin/domain/entities/capturista_entity.dart';

class CapturistRepositoryImpl implements CapturistRepository {
  final CapturistRemoteDataSource remoteDataSource;

  CapturistRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<CapturistaEntity>> getCapturistasByInstitution(int institutionId) {
    return remoteDataSource.getCapturistasByInstitution(institutionId);
  }

  @override
  Future<void> updateCapturistaStatus(String email, String status) {
    return remoteDataSource.updateCapturistaStatus(email, status);
  }
}
