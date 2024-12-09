import 'package:sigede_flutter/modules/auth/data/datasources/login_remote_data_source.dart';
import 'package:sigede_flutter/modules/auth/data/models/login_model.dart';

abstract class LoginRepository {
  Future<ResponseLoginModel> login(LoginModel model);
}

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource loginRemoteDataSource;

  LoginRepositoryImpl({required this.loginRemoteDataSource});

  @override
  Future<ResponseLoginModel> login(LoginModel model) async {
    return await loginRemoteDataSource.login(model);
  }
}