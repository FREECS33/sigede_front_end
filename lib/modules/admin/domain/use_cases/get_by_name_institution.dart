import 'package:sigede_flutter/modules/admin/data/models/capturista_model.dart';
import 'package:sigede_flutter/modules/admin/data/repositories/capturer_repository.dart';

class GetByNameInstitution {
  final CapturerRepository repository;

  GetByNameInstitution({required this.repository});

  Future<List<CapturistaModel>> call(FilterCapturerModel model) {
    return repository.getCapturerByName(model);
  }
}