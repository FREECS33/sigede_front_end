import 'package:sigede_flutter/screens/auth/data/models/recovery_password_model.dart';
import 'package:sigede_flutter/screens/auth/data/repositories/recovery_password_repository.dart';
import 'package:sigede_flutter/screens/auth/domain/entities/recovery_password_entity.dart';

class RecoveryPassword {
  final RecoveryPasswordRepository repository;

  RecoveryPassword({required this.repository});

  Future<RecoveryPasswordEntity> call(RecoveryPasswordModel model) async {
    return await repository.recoveryPassword(model);
  }
}