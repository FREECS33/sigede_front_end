import 'package:sigede_flutter/screens/auth/models/capturista.dart';
import 'package:sigede_flutter/screens/auth/repositories/capturista_repository.dart';

class UpdateCapturista {
  final CapturistaRepository repository;

  UpdateCapturista(this.repository);

  Future<void> call(Capturista capturista) async {
    await repository.updateCapturista(capturista);
  }
}