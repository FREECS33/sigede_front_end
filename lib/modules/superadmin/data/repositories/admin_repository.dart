import 'package:sigede_flutter/modules/superadmin/data/datasources/admin_data_source.dart';
import 'package:sigede_flutter/modules/superadmin/data/models/admin_model.dart';

abstract class AdminRepository {
  Future<List<AdminModel>> getAllAdmins(RequestAdminModel model);
  //Future<List<AdminModel>> getAdminByName(PageModel model);
}

class AdminRepositoryImpl implements AdminRepository {
  final AdminDataSource adminDataSource;

  AdminRepositoryImpl({required this.adminDataSource});

  @override
  Future<List<AdminModel>> getAllAdmins(RequestAdminModel model) async {
    return adminDataSource.getAllAdmins(model);
  }

  // @override
  // Future<List<AdminModel>> getAdminByName(PageModel model) async {
  //   return adminDataSource.getAdminByName(model);
  // }
}