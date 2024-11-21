import 'package:sigede_flutter/kernel/utils/dio_client.dart';
import 'package:sigede_flutter/screens/auth/entities/auth_user.dart';
import 'package:sigede_flutter/screens/auth/models/auth_model.dart';

abstract class LoginRemoteDataSource {
  Future<AuthUser> login (AuthModel authModel);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource{
  final DioClient dioClient;

  LoginRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<AuthUser> login(AuthModel authModel) async {
    try{
      final response = await dioClient.dio.post('/login');
      return AuthModel.fromJson(response.data);
    }catch(e){
      throw Exception('Failed to create user');
    }
  }
}