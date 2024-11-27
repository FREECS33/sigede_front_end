import 'package:sigede_flutter/screens/auth/data/models/reset_password_model.dart';
import 'package:sigede_flutter/screens/auth/data/repositories/reset_password_repository.dart';
import 'package:sigede_flutter/screens/auth/domain/entities/reset_password_entity.dart';

class ResetPassword {
  final ResetPasswordRepository repository;

  ResetPassword({required this.repository});

  Future<ResetPasswordEntity> call(ResetPasswordModel model) async {
    return await repository.resetPassword(model);
  }
}