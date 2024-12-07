import 'package:sigede_flutter/modules/superadmin/data/datasources/admin_data_source.dart';
import 'package:sigede_flutter/modules/superadmin/data/models/admin_model.dart';

abstract class AdminRepository {
  Future<List<AdminModel>> getAllAdmins(RequestAdminModel model);
  Future<List<AdminModel>> getAdminByName(FilterAdminModel model);
  Future<ResponseAddAdminModel> addAdmin(AddAdminModel model);
  Future<ResponseAddAdminModel> updateAdmin(UpdateAdminStatusModel model);
  Future<ResponseAddAdminModel> updateInfoAdmin(UpdateInfoAdminModel model);
}

class AdminRepositoryImpl implements AdminRepository {
  final AdminDataSource adminDataSource;

  AdminRepositoryImpl({required this.adminDataSource});

  @override
  Future<List<AdminModel>> getAllAdmins(RequestAdminModel model) async {
    return adminDataSource.getAllAdmins(model);
  }

  @override
  Future<List<AdminModel>> getAdminByName(FilterAdminModel model) async {
    return adminDataSource.getAdminByName(model);
  }

  @override
  Future<ResponseAddAdminModel> addAdmin(AddAdminModel model) async {
    return adminDataSource.addAdmin(model);
  }

  @override
  Future<ResponseAddAdminModel> updateAdmin(UpdateAdminStatusModel model) async {
    return adminDataSource.updateAdmin(model);
  }

  @override
  Future<ResponseAddAdminModel> updateInfoAdmin(UpdateInfoAdminModel model) async {
    return adminDataSource.updateInfoAdmin(model);
  }
}
