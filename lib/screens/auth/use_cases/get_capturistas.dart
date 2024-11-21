import 'package:sigede_flutter/screens/auth/models/capturista.dart';
import 'package:sigede_flutter/screens/auth/repositories/capturista_repository.dart';

class GetCapturistas {
  final CapturistaRepository repository;

  GetCapturistas({required this.repository});

  Future<List<Capturista>> call() async {
    return await repository.getAllCapturistas();
  }
}