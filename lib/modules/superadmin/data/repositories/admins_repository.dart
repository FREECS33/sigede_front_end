import 'package:sigede_flutter/modules/superadmin/data/datasources/admins_data_source.dart';
import 'package:sigede_flutter/modules/superadmin/data/models/admins_model.dart';
import 'package:sigede_flutter/modules/superadmin/domain/entities/admins_entity.dart';

abstract class AdminsRepository {
  Future<List<AdminsEntity>> getAdmins(AdminsModel model);
}

class AdminsRepositoryImpl implements AdminsRepository {
  final AdminsDataSource adminsDataSource;

  AdminsRepositoryImpl({required this.adminsDataSource});

  @override
  Future<List<AdminsEntity>> getAdmins(AdminsModel model) async {
    return await adminsDataSource.getAdmins(model);
  }
}