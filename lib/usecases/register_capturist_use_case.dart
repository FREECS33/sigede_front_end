import 'package:sigede_flutter/data/models/capturist_model.dart';
import 'package:sigede_flutter/data/repositories/capturist_repository.dart';

class RegisterCapturistUseCase {
  final CapturistRepository repository;

  RegisterCapturistUseCase(this.repository);

  Future<void> call(CapturistModel capturist) {
    return repository.registerCapturist(capturist);
  }
}