import 'package:sigede_flutter/modules/auth/data/models/code_confirmation_model.dart';
import 'package:sigede_flutter/modules/auth/data/repositories/code_confirmation_repository.dart';

class CodeConfirmation {
  final CodeConfirmationRepository repository;

  CodeConfirmation({required this.repository});

  Future<ResponseCodeConfirmationModel> call(CodeConfirmationModel model) async {
    return await repository.codeConfirmation(model);
  }
}