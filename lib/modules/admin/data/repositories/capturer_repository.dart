import 'package:sigede_flutter/modules/admin/data/datasources/capturist_remote_data_source.dart';
import 'package:sigede_flutter/modules/admin/data/models/capturista_model.dart';
import 'package:sigede_flutter/modules/admin/data/models/institution_capturer_model.dart';
import 'package:sigede_flutter/modules/superadmin/data/models/admin_model.dart';

abstract class CapturerRepository {
  Future<List<CapturistaModel>> getCapturerByName(FilterCapturerModel model);
  Future<InstitutionCapturerModel> getOneInstitution(int institutionId);
}

class CapturerRepositoryImpl implements CapturerRepository {
  final CapturistRemoteDataSource capturerDataSource;

  CapturerRepositoryImpl({required this.capturerDataSource});

  @override
  Future<List<CapturistaModel>> getCapturerByName(FilterCapturerModel model) async {
    return capturerDataSource.getCapturerByName(model);
  }

  @override
  Future<InstitutionCapturerModel> getOneInstitution(int institutionId) {
    return capturerDataSource.getOneInstitution(institutionId);
  }
}