import 'package:sigede_flutter/modules/superadmin/data/models/institution_new_model.dart';
import 'package:sigede_flutter/modules/superadmin/data/repositories/institution_new_repository.dart';
import 'package:sigede_flutter/modules/superadmin/domain/entities/institution_new_entity.dart';

class PostInstitution {
  final InstitutionNewRepository _institutionRepository;

  PostInstitution(this._institutionRepository);

  Future<InstitutionNewEntity> call(InstitutionNewModel model) async {
    return await _institutionRepository.postInstitution(model);
  }
}