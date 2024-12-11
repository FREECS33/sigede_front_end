
import 'package:sigede_flutter/modules/admin/data/repositories/capturist_repository.dart';
import 'package:sigede_flutter/modules/admin/domain/entities/capturista_entity.dart';

class GetCapturistas {
  final CapturistRepository repository;

  GetCapturistas({required this.repository});

  Future<List<CapturistaEntity>> call(int institutionId) async{
    return await repository.getCapturistasByInstitution(institutionId);
  }
}
