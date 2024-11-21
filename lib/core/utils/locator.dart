import 'package:get_it/get_it.dart';
import 'package:sigede_flutter/core/utils/dio_client.dart';
import 'package:sigede_flutter/screens/auth/data/datasources/login_remote_data_source.dart';
final locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(() => DioClient(baseUrl: 'http://localhost:8080'));

  locator.registerFactory<LoginRemoteDataSource>(()=> LoginRemoteDataSourceImpl(dioClient:locator()));
}