import 'package:get_it/get_it.dart';
import 'package:sigede_flutter/core/utils/dio_client.dart';
import 'package:sigede_flutter/screens/auth/data/datasources/login_remote_data_source.dart';
import 'package:sigede_flutter/screens/auth/data/repositories/login_repository.dart';
import 'package:sigede_flutter/screens/auth/domain/use_cases/login.dart';
final locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(() => DioClient(baseUrl: 'http://localhost:8080'));

  // Registrar el LoginRemoteDataSource
  locator.registerFactory<LoginRemoteDataSource>(() => LoginRemoteDataSourceImpl(dioClient: locator()));

  // Registrar el LoginRepository (esto debe ser el repositorio que utiliza el datasource)
  locator.registerFactory<LoginRepository>(() => LoginRepositoryImpl(loginRemoteDataSource: locator()));

  // Registrar el caso de uso Login
  locator.registerFactory<Login>(() => Login(repository: locator()));
}