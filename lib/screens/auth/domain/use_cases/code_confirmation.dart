import 'package:sigede_flutter/screens/auth/data/models/code_confirmation_model.dart';
import 'package:sigede_flutter/screens/auth/data/repositories/code_confirmation_repository.dart';
import 'package:sigede_flutter/screens/auth/domain/entities/code_confirmation_entity.dart';

class CodeConfirmation {
  final CodeConfirmationRepository repository;

  CodeConfirmation({required this.repository});

  Future<CodeConfirmationEntity> call(CodeConfirmationModel model) async {
    return await repository.codeConfirmation(model);
  }
}