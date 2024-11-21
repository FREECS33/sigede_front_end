import 'package:dio/dio.dart';
import 'package:sigede_flutter/screens/auth/data/datasources/login_remote_data_source.dart';
import 'package:sigede_flutter/screens/auth/data/models/login_model.dart';
import 'package:sigede_flutter/screens/auth/domain/entities/login_entity.dart';

abstract class LoginRepository {
  Future<LoginEntity> login(LoginEntity LoginEntity);
}

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource loginRemoteDataSource;

  LoginRepositoryImpl({required this.loginRemoteDataSource});

  @override
  Future<LoginEntity> login(LoginEntity LoginEntity) async {
    return await loginRemoteDataSource.login(LoginEntity as LoginModel);
  }
}