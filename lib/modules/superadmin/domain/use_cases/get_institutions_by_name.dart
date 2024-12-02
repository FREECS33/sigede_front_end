import 'package:sigede_flutter/modules/superadmin/data/repositories/institution_repository.dart';
import 'package:sigede_flutter/modules/superadmin/domain/entities/institution_entity.dart';

class GetInstitutionsByName {
  final InstitutionRepository repository;

  GetInstitutionsByName({required this.repository});

  Future<InstitutionResponseEntity> call(String name, int page, int size) async {
    return await repository.getInstitutionsByName(name, page, size);
  }
}
