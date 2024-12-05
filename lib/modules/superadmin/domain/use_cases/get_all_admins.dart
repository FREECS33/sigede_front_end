import 'package:sigede_flutter/modules/superadmin/data/models/admins_model.dart';
import 'package:sigede_flutter/modules/superadmin/data/repositories/admins_repository.dart';
import 'package:sigede_flutter/modules/superadmin/domain/entities/admins_entity.dart';

class GetAllAdmins {
  final AdminsRepository repository;

  GetAllAdmins({required this.repository});

  Future<List<AdminsEntity>> call(AdminsModel model) async {
    return await repository.getAdmins(model);
  }
}