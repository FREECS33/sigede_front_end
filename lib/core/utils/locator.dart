import 'package:get_it/get_it.dart';
import 'package:sigede_flutter/core/utils/dio_client.dart';
import 'package:sigede_flutter/modules/admin/data/datasources/capturista_remote_data_source.dart';
import 'package:sigede_flutter/modules/auth/data/datasources/code_confirmation_data_source.dart';
import 'package:sigede_flutter/modules/auth/data/datasources/login_remote_data_source.dart';
import 'package:sigede_flutter/modules/auth/data/datasources/recovery_password_data_source.dart';
import 'package:sigede_flutter/modules/auth/data/datasources/reset_password_data_source.dart';
import 'package:sigede_flutter/modules/admin/data/repositories/capturista_repository.dart';
import 'package:sigede_flutter/modules/auth/data/repositories/code_confirmation_repository.dart';
import 'package:sigede_flutter/modules/auth/data/repositories/login_repository.dart';
import 'package:sigede_flutter/modules/auth/data/repositories/recovery_password_repository.dart';
import 'package:sigede_flutter/modules/auth/data/repositories/reset_password_repository.dart';
import 'package:sigede_flutter/modules/auth/domain/use_cases/code_confirmation.dart';
import 'package:sigede_flutter/modules/admin/domain/use_cases/get_capturistas.dart';
import 'package:sigede_flutter/modules/auth/domain/use_cases/login.dart';
import 'package:sigede_flutter/modules/auth/domain/use_cases/recovery_password.dart';
import 'package:sigede_flutter/modules/auth/domain/use_cases/reset_password.dart';

final locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(() => DioClient(baseUrl: 'http://localhost:8080'));

  // Registrar el LoginRemoteDataSource
  locator.registerFactory<LoginRemoteDataSource>(() => LoginRemoteDataSourceImpl(dioClient: locator()));

  // Registrar el LoginRepository (esto debe ser el repositorio que utiliza el datasource)
  locator.registerFactory<LoginRepository>(() => LoginRepositoryImpl(loginRemoteDataSource: locator()));

  // Registrar el caso de uso Login
  locator.registerFactory<Login>(() => Login(repository: locator()));

  // Registrar el RecoveryPassowrdDataSource
  locator.registerFactory<RecoveryPasswordRemoteDataSource>(() => RecoveryPasswordRemoteDataSourceImpl(dioClient: locator()));

  // Registrar el RecoveryPasswordRepository
  locator.registerFactory<RecoveryPasswordRepository>(() => RecoveryPasswordRepositoryImpl(recoveryPasswordRemoteDataSource: locator()));

  // Registrar el caso de uso RecoveryPassword
  locator.registerFactory<RecoveryPassword>(() => RecoveryPassword(repository: locator()));

  /// Registrar el CodeConfirmationDataSource
  locator.registerFactory<CodeConfirmationDataSource>(() => CodeConfirmationDataSourceImpl(dioClient: locator()));
  /// Registrar el CodeConfirmationRepository
  locator.registerFactory<CodeConfirmationRepository>(() => CodeConfirmationRepositoryImpl(codeConfirmationDataSource: locator()));
  /// Registrar el caso de uso CodeConfirmation
  locator.registerFactory<CodeConfirmation>(() => CodeConfirmation(repository: locator()));

  // Registrar el ResetPasswordDataSource
  locator.registerFactory<ResetPasswordDataSource>(() => ResetPasswordDataSourceImpl(dioClient: locator()));
  // Registrar el ResetPasswordRepository
  locator.registerFactory<ResetPasswordRepository>(() => ResetPasswordRepositoryImpl(resetPasswordDataSource: locator()));
  // Registrar el caso de uso ResetPassword
  locator.registerFactory<ResetPassword>(() => ResetPassword(repository: locator()));

  // Registro de CapturistaRemoteDataSource
  locator.registerFactory<CapturistaRemoteDataSource>(
    () => CapturistaRemoteDataSourceImpl(dioClient: locator()));
  // Repositorios
  locator.registerFactory<CapturistaRepository>(
    () => CapturistaRepositoryImpl(capturistaRemoteDataSource: locator()));
  // Casos de uso
  locator.registerFactory(() => GetCapturistas(repository: locator()));
}