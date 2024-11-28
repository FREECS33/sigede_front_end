import 'package:sigede_flutter/modules/superadmin/data/models/institutions_model.dart';
import 'package:sigede_flutter/modules/superadmin/data/repositories/institutions_repository.dart';
import 'package:sigede_flutter/modules/superadmin/domain/entities/institutions_entity.dart';

class Institutions {
  final InstitutionsRepository repository;

  Institutions({required this.repository});

  Future<InstitutionsEntity> call() async {
    return await repository.getAllInstitutions();
  }
}