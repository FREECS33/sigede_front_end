import 'package:get_it/get_it.dart';
import 'package:sigede_flutter/kernel/utils/dio_capturista.dart';
import 'package:sigede_flutter/screens/auth/datasource/user_remote_data_source.dart';
import 'package:sigede_flutter/screens/auth/repositories/capturista_repository.dart';
import 'package:sigede_flutter/screens/auth/use_cases/get_capturista.dart';
final locator = GetIt.instance;
void setupLocator() {
  // DioClient
  locator.registerLazySingleton(() => DioClient(baseUrl: 'https://mocki.io/v1/5f699646-f756-4e53-8383-2a338d31101a'));

  // Data Sources
  locator.registerFactory<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(dioClient: locator()));

  // Repositorios
  locator.registerFactory<CapturistaRepository>(() => UserRepositoryImpl(remoteDataSource: locator()));

  // Casos de uso
  locator.registerFactory(() => GetCapturista(repository: locator()));
}
