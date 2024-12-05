import 'package:dio/dio.dart';
import 'package:sigede_flutter/core/utils/dio_client.dart';
import 'package:sigede_flutter/modules/superadmin/data/models/admins_model.dart';
import 'package:sigede_flutter/modules/superadmin/domain/entities/admins_entity.dart';

abstract class AdminsDataSource {
  Future<List<AdminsEntity>> getAdmins(AdminsModel model);
}

class AdminsDataSourceImpl implements AdminsDataSource{
  final DioClient dioClient;

  AdminsDataSourceImpl({required this.dioClient});

  @override
  Future<List<AdminsEntity>> getAdmins(AdminsModel model) async {
    try {
      final response = await dioClient.dio.post(
        '/api/users/get-all-by-institution-rolename?page=0&size=200&sort=name,desc',
        data: model.toJson(),
      );
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        final adminsList = (response.data['data']['content'] as List)
          .map((admin) => AdminsEntity.fromJson(admin))
          .toList();      
      return adminsList;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } catch (e) {
      throw Exception('Error fetching admins: $e');
    }
  }
}