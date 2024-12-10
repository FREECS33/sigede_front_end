import 'package:sigede_flutter/modules/auth/data/models/login_model.dart';
import 'package:sigede_flutter/modules/auth/data/repositories/login_repository.dart';

class Login {
  final LoginRepository repository;

  Login({required this.repository});

  Future<ResponseLoginModel> call(LoginModel model) async {
    return await repository.login(model);
  }
}