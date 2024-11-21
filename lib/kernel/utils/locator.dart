import 'package:get_it/get_it.dart';
import 'package:learning_flutter_b/modules/auth/datasource/user_remote_data_source.dart';
import 'package:learning_flutter_b/modules/auth/repositories/user_repository.dart';
import 'package:learning_flutter_b/modules/auth/use_cases/create_user.dart';
import 'package:learning_flutter_b/modules/auth/use_cases/get_user.dart';
import 'dio_client.dart';


final locator = GetIt.instance;

void setupLocator() {
  // Registro de dependencias
  locator.registerLazySingleton(() => DioClient(baseUrl: 'https://localhost:8080/api/capturists'));
  
  // Data Sources
  locator.registerFactory<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(dioClient: locator()));

  // Repositorios
  locator.registerFactory<UserRepository>(() => UserRepositoryImpl(remoteDataSource: locator()));

  // Casos de uso
  //locator.registerFactory(() => GetUser(repository: locator()));
  //locator.registerFactory(() => CreateUser(repository: locator()));
}
