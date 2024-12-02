import 'package:sigede_flutter/modules/superadmin/data/datasources/institution_post_data_source.dart';
import 'package:sigede_flutter/modules/superadmin/data/models/institution_new_model.dart';
import 'package:sigede_flutter/modules/superadmin/domain/entities/institution_new_entity.dart';

abstract class InstitutionNewRepository {
  Future<InstitutionNewEntity> postInstitution(InstitutionNewModel model);
}

class InstitutionNewRepositoryImpl implements InstitutionNewRepository {
  final InstitutionPostDataSource institutionPostDataSource;

  InstitutionNewRepositoryImpl({required this.institutionPostDataSource});

  @override
  Future<InstitutionNewEntity> postInstitution(InstitutionNewModel model) async {
    return await institutionPostDataSource.postInstitution(model);
  }
}