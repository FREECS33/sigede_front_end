
import 'package:sigede_flutter/modules/admin/data/repositories/capturist_repository.dart';

class UpdateCapturistaStatus {
  final CapturistRepository repository;

  UpdateCapturistaStatus({required this.repository});

  Future<void> call(String email, String status) {
    return repository.updateCapturistaStatus(email, status);
  }
}
