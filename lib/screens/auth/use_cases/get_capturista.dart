import 'package:sigede_flutter/screens/auth/models/capturista.dart';
import 'package:sigede_flutter/screens/auth/repositories/capturista_repository.dart';

class GetCapturista {
  final CapturistaRepository repository;

  GetCapturista({required this.repository});

  Future<Capturista> call(String id) async {
    return await repository.getUser(id);
  }
}