import 'package:get_it/get_it.dart';
import 'package:sigede_flutter/core/utils/dio_client.dart';
import 'package:sigede_flutter/modules/admin/data/datasources/capturist_remote_data_source.dart';
import 'package:sigede_flutter/modules/admin/data/datasources/capturista_remote_data_source.dart';
import 'package:sigede_flutter/modules/admin/data/repositories/capturer_repository.dart';
import 'package:sigede_flutter/modules/admin/data/repositories/capturist_repository.dart';
import 'package:sigede_flutter/modules/admin/data/repositories/capturista_repository_impl.dart';
import 'package:sigede_flutter/modules/admin/domain/use_cases/disable_capturista.dart';
import 'package:sigede_flutter/modules/admin/domain/use_cases/get_by_name_institution.dart';
import 'package:sigede_flutter/modules/admin/domain/use_cases/get_capturista.dart';
import 'package:sigede_flutter/modules/admin/domain/use_cases/get_one_institution.dart';
import 'package:sigede_flutter/modules/admin/domain/use_cases/post_capturista.dart';
import 'package:sigede_flutter/modules/admin/domain/use_cases/put_capturista.dart';
import 'package:sigede_flutter/modules/admin/domain/use_cases/update_capturista_status.dart';
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
import 'package:sigede_flutter/modules/capturista/data/datasources/credential_remote_data_source.dart';
import 'package:sigede_flutter/modules/capturista/data/repositories/credential_repository.dart';
import 'package:sigede_flutter/modules/capturista/domain/use_cases/get_credentials.dart';
import 'package:sigede_flutter/modules/superadmin/data/datasources/admin_data_source.dart';
import 'package:sigede_flutter/modules/superadmin/data/datasources/institution_data_source.dart';
import 'package:sigede_flutter/modules/superadmin/data/repositories/admin_repository.dart';
import 'package:sigede_flutter/modules/superadmin/data/repositories/institution_repository.dart';
import 'package:sigede_flutter/modules/superadmin/domain/use_cases/admin_cases/admin_use_case.dart';
import 'package:sigede_flutter/modules/superadmin/domain/use_cases/institution_cases/institution_use_case.dart';
import 'package:sigede_flutter/shared/services/token_service.dart';



final locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton<DioClient>(() => DioClient());

  locator.registerLazySingleton<TokenService>(() => TokenService());  

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
  //Registrar el caso de uso AddInstitution
  locator.registerFactory<AddInstitution>(() => AddInstitution(repository: locator()));

  //Registrar AdminDataSource
  locator.registerFactory<AdminDataSource>(() => AdminsDataSourceImpl(dioClient: locator()));
  //Registrar AdminRepository
  locator.registerFactory<AdminRepository>(() => AdminRepositoryImpl(adminDataSource: locator()));
  //Registrar el caso de uso GetAdmins
  locator.registerFactory<GetAllAdmin>(() => GetAllAdmin(repository: locator()));
  
  locator.registerFactory<GetAdminByName>(() => GetAdminByName(repository: locator()));  

  locator.registerFactory<AddNewAdmin>(() => AddNewAdmin(repository: locator()));

  locator.registerFactory<UpdateAdminInfo>(() => UpdateAdminInfo(repository: locator()));

  locator.registerFactory<UpdateInfoAdmin>(() => UpdateInfoAdmin(repository: locator()));

  locator.registerFactory<CredentialRemoteDataSource>(()=> CredentialRemoteDataSourceImpl(dioClient: locator()));
  locator.registerFactory<CredentialRepository>(()=> CredentialRepositoryImpl(credentialRemoteDataSource: locator()));
  locator.registerFactory(()=> GetCredentials(repository: locator()));

   // Registrar CapturistRemoteDataSource
  locator.registerFactory<CapturistRemoteDataSource>(
    () => CapturistRemoteDataSourceImpl(dioClient: locator()),
  );

  // Registrar CapturistaRepo
  locator.registerFactory<CapturistRepository>(
    () => CapturistRepositoryImpl(remoteDataSource: locator<CapturistRemoteDataSource>()),
  );

  // Registrar casos de uso  
  locator.registerFactory(() => UpdateCapturistaStatus(repository: locator()));
  locator.registerFactory<CapturerRepository>(() => CapturerRepositoryImpl(capturerDataSource: locator()));
  locator.registerFactory<GetByNameInstitution>(() => GetByNameInstitution(repository: locator()));  
  locator.registerFactory<GetOneInstitution>(() => GetOneInstitution(repository: locator()));  
}

