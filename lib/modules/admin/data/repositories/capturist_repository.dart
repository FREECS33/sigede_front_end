import 'package:sigede_flutter/modules/admin/domain/entities/capturista_entity.dart';

abstract class CapturistRepository {
  Future<List<CapturistaEntity>> getCapturistasByInstitution(int institutionId);
  Future<void> updateCapturistaStatus(String email, String status);
}
