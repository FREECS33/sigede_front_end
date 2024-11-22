import 'package:dio/dio.dart';
import 'package:sigede_flutter/core/utils/dio_client.dart';
import 'package:sigede_flutter/screens/auth/data/models/login_model.dart';
import 'package:sigede_flutter/screens/auth/domain/entities/login_entity.dart';

abstract class LoginRemoteDataSource {
  Future<LoginEntity> login(LoginModel loginModel);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final DioClient dioClient;

  LoginRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<LoginEntity> login(LoginModel loginModel) async {
    try {
      final response = await dioClient.dio.post(
        '/api/login',
        data: loginModel.toJson(),
      );
      return LoginModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create user');
    }
  }
}