import 'package:sigede_flutter/modules/superadmin/data/models/institution_new_model.dart';
import 'package:sigede_flutter/modules/superadmin/data/repositories/institution_new_repository.dart';
import 'package:sigede_flutter/modules/superadmin/domain/entities/institution_new_entity.dart';
import 'package:sigede_flutter/modules/superadmin/domain/entities/institutions_entity.dart';

class PostInstitution {
  final InstitutionNewRepository repository;

  PostInstitution({required this.repository});

  Future<InstitutionsEntity> call(InstitutionNewModel model) async {
    return await repository.postInstitution(model);
  }
}