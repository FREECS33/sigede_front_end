import 'package:sigede_flutter/screens/auth/data/models/login_model.dart';
import 'package:sigede_flutter/screens/auth/data/repositories/login_repository.dart';
import 'package:sigede_flutter/screens/auth/domain/entities/login_entity.dart';

class Login {
  final LoginRepository repository;

  Login({required this.repository});

  Future<LoginEntity> call(LoginModel model) async {
    return await repository.login(model);
  }
}