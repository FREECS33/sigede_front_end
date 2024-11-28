import 'package:sigede_flutter/modules/auth/data/models/capturista.dart';
import 'package:sigede_flutter/modules/auth/data/repositories/capturista_repository.dart';

class GetCapturistas {
  final CapturistaRepository repository;

  GetCapturistas({required this.repository});

  Future<List<Capturista>> call({
    required String role,
    required int institutionId,
  }) {
    return repository.getAllCapturistas(
      role: role,
      institutionId: institutionId,
    );
  }
}