import 'package:get_it/get_it.dart';
import 'package:sigede_flutter/core/utils/dio_client.dart';
import 'package:sigede_flutter/modules/admin/data/datasources/capturista_remote_data_source.dart';
import 'package:sigede_flutter/modules/admin/domain/use_cases/disable_capturista.dart';
import 'package:sigede_flutter/modules/admin/domain/use_cases/get_capturista.dart';
import 'package:sigede_flutter/modules/admin/domain/use_cases/post_capturista.dart';
import 'package:sigede_flutter/modules/admin/domain/use_cases/put_capturista.dart';
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
import 'package:sigede_flutter/modules/superadmin/data/datasources/admin_data_source.dart';
import 'package:sigede_flutter/modules/superadmin/data/datasources/admins_data_source.dart';
import 'package:sigede_flutter/modules/superadmin/data/datasources/institution_data_source.dart';
import 'package:sigede_flutter/modules/superadmin/data/datasources/institution_post_data_source.dart';
import 'package:sigede_flutter/modules/superadmin/data/datasources/institutions_all_data_source.dart';
import 'package:sigede_flutter/modules/superadmin/data/repositories/admin_repository.dart';
import 'package:sigede_flutter/modules/superadmin/data/repositories/admins_repository.dart';
import 'package:sigede_flutter/modules/superadmin/data/repositories/institution_new_repository.dart';
import 'package:sigede_flutter/modules/superadmin/data/repositories/institution_repository.dart';
import 'package:sigede_flutter/modules/superadmin/data/repositories/institutions_repository.dart';
import 'package:sigede_flutter/modules/superadmin/domain/use_cases/get_all_admins.dart';
import 'package:sigede_flutter/modules/superadmin/domain/use_cases/get_all_institutions.dart';
import 'package:sigede_flutter/modules/superadmin/domain/use_cases/get_institution_by_name.dart';
import 'package:sigede_flutter/modules/superadmin/domain/use_cases/get_institutions_by_name.dart';
import 'package:sigede_flutter/modules/superadmin/domain/use_cases/institutions.dart';
import 'package:sigede_flutter/modules/superadmin/domain/use_cases/post_admin.dart';
import 'package:sigede_flutter/modules/superadmin/domain/use_cases/post_institution.dart';

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

  //Registrar el InstitucionDataSource
  locator.registerFactory<InstitutionDataSource>(() => InstitutionDataSourceImpl(dioClient: locator()));
  //Registrar el InstitucionRepository
  locator.registerFactory<InstitutionRepository>(() => InstitutionRepositoryImpl(institutionDataSource: locator()));
  //Registrar el caso de uso Institucion
  locator.registerFactory<GetAllInstitutions>(() => GetAllInstitutions(repository: locator()));

  // Registro de CapturistaRemoteDataSource
  locator.registerFactory<CapturistaRemoteDataSource>(
    () => CapturistaRemoteDataSourceImpl(dioClient: locator()));
  // Repositorios capturista
  locator.registerFactory<CapturistaRepository>(
    () => CapturistaRepositoryImpl(capturistaRemoteDataSource: locator()));
  // Casos de uso capturista
  locator.registerFactory(() => GetCapturistas(repository: locator()));
  locator.registerFactory(() => GetCapturista(repository: locator()));
  locator.registerFactory(()=> PutCapturista(repository: locator()));
  locator.registerFactory(()=> DisableCapturista(repository: locator()));
  locator.registerFactory(()=>PostCapturista(repository: locator()));

  //Registrar el caso de uso GetInstitutionsByName
  locator.registerFactory<GetInstitutionByName>(() => GetInstitutionByName(repository: locator()));
 /*
  //Registrar InstitutionPostDataSource
  locator.registerFactory<InstitutionPostDataSource>(() => InstitutionPostDataSourceImpl(dioClient: locator()));
  //Registrar InstitutionPostRepository
  locator.registerFactory<InstitutionNewRepository>(() => InstitutionNewRepositoryImpl(institutionPostDataSource: locator()));
  //Registrar el caso de uso PostInstitution
  locator.registerFactory<PostInstitution>(() => PostInstitution(repository: locator()));

  //registrar admin_data_source
  locator.registerFactory<AdminDataSource>(() => AdminDataSourceImpl(dioClient: locator()));
  //registrar admin_repository
  locator.registerFactory<AdminRepository>(() => AdminRepositoryImpl(adminDataSource: locator()));
  //registrar el caso de uso PostAdmin
  locator.registerFactory<PostAdmin>(() => PostAdmin(repository: locator()));
  
  //Registrar Admins data source
  locator.registerFactory<AdminsDataSource>(() => AdminsDataSourceImpl(dioClient: locator()));
  //Registrar AdminRepository
  locator.registerFactory<AdminsRepository>(() => AdminsRepositoryImpl(adminsDataSource: locator()));
  //Registrar el caso de uso GetAdmins
  locator.registerFactory<GetAllAdmins>(() => GetAllAdmins(repository: locator()));
  */
}

