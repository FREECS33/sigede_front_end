import 'package:sigede_flutter/modules/superadmin/data/models/admin_model.dart';
import 'package:sigede_flutter/modules/superadmin/data/repositories/admin_repository.dart';

class GetAllAdmin {
  final AdminRepository repository;

  GetAllAdmin({required this.repository});

  Future<List<AdminModel>> call(RequestAdminModel model) async {
    return await repository.getAllAdmins(model);
  }
}

class GetAdminByName {
  final AdminRepository repository;

  GetAdminByName({required this.repository});

  Future<List<AdminModel>> call(FilterAdminModel model) async {
    return await repository.getAdminByName(model);
  }
}

class AddNewAdmin {
  final AdminRepository repository;

  AddNewAdmin({required this.repository});

  Future<ResponseAddAdminModel> call(AddAdminModel model) async {
    return await repository.addAdmin(model);
  }
}