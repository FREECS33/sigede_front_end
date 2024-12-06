import 'package:dio/dio.dart';
import 'package:sigede_flutter/core/utils/dio_client.dart';
import 'package:sigede_flutter/modules/superadmin/data/models/admin_model.dart';

abstract class AdminDataSource {
  Future<List<AdminModel>> getAllAdmins(RequestAdminModel model);
  Future<List<AdminModel>> getAdminByName(FilterAdminModel model);
}

class AdminsDataSourceImpl implements AdminDataSource {
  final DioClient dioClient;

  AdminsDataSourceImpl({required this.dioClient});

  @override
  Future<List<AdminModel>> getAllAdmins(RequestAdminModel model) async {
    try {
      final response = await dioClient.dio.post('/api/users/get-all-by-institution-rolename?page=0&size=200&sort=name,desc', data: model.toJson());

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        // Verificar si 'data' es una lista antes de mapear
        if (response.data['data']['content'] is List) {
          return (response.data['data']['content'] as List)
              .map((json) => AdminModel.fromJson(json))
              .toList();
        } else {
          throw Exception('Expected a list in response.data["data"]');
        }
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (dioError) {
      if (dioError.response != null) {
        switch (dioError.response?.statusCode) {
          case 400:
            throw Exception("Bad Request: ${dioError.response?.data}");
          case 401:
            throw Exception("Unauthorized: ${dioError.response?.data}");
          case 403:
            throw Exception("Forbidden: ${dioError.response?.data}");
          case 500:
            throw Exception("Internal Server Error: ${dioError.response?.data}");
          default:
            throw Exception("Unhandled Error: ${dioError.response?.data}");
        }
      } else {
        throw Exception('Network error: ${dioError.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<List<AdminModel>> getAdminByName(FilterAdminModel model) async {
    try{
      final response = await dioClient.dio.post(
        '/api/admin/get-admins-by-name-and-institution',
        data: model.toJson()
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        // Verificar si 'data' es una lista antes de mapear
        if (response.data['data']['content'] is List) {
          return (response.data['data']['content'] as List)
              .map((json) => AdminModel.fromJson(json))
              .toList();
        } else {
          throw Exception('Expected a list in response.data["data"]');
        }
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (dioError) {
      if (dioError.response != null) {
        switch (dioError.response?.statusCode) {
          case 400:
            throw Exception("Bad Request: ${dioError.response?.data}");
          case 401:
            throw Exception("Unauthorized: ${dioError.response?.data}");
          case 403:
            throw Exception("Forbidden: ${dioError.response?.data}");
          case 500:
            throw Exception("Internal Server Error: ${dioError.response?.data}");
          default:
            throw Exception("Unhandled Error: ${dioError.response?.data}");
        }
      } else {
        throw Exception('Network error: ${dioError.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
}