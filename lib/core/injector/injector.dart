import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:uni_miskolc_datashare/core/network/network_info.dart';
import 'package:uni_miskolc_datashare/core/secure_store/secure_store.dart';
import 'package:uni_miskolc_datashare/core/secure_store/secure_store_impl.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/datasources/main_activity_remote_datasource.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/datasources/main_activity_remote_datasource_impl.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/repositories/main_activity_repository_impl.dart';
import 'package:uni_miskolc_datashare/features/main_activity/domain/repositories/main_activity_repository.dart';
import 'package:uni_miskolc_datashare/features/main_activity/domain/usecases/get_user_model_data.dart';
import 'package:uni_miskolc_datashare/features/main_activity/domain/usecases/save_user_model_data.dart';
import 'package:uni_miskolc_datashare/features/main_activity/presentation/bloc/main_activity_bloc.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/data/datasources/provider_activity_remote_data_source.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/data/datasources/provider_activity_remote_data_source_impl.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/data/repostirories/provider_activity_repositoy_impl.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/domain/repositories/provider_activity_repository.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/domain/usecases/get_required_data_list.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/domain/usecases/save_required_data_list.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/presentation/bloc/provider_activity_bloc.dart';
import 'package:uni_miskolc_datashare/features/session_handler/data/datasources/remote_datasource.dart';
import 'package:uni_miskolc_datashare/features/session_handler/data/datasources/remote_datasource_impl.dart';
import 'package:uni_miskolc_datashare/features/session_handler/data/repositories/session_handler_repostiory_impl.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/repositories/session_handler_repository.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/chack_account_type.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/check_if_logged_in.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/login.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/logout.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/resend_verification_email.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/signup.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/update_account_type.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/update_user_profile.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/waiting_for_email_verification.dart';
import 'package:uni_miskolc_datashare/features/session_handler/presentation/bloc/session_handler_bloc.dart';

final injector = GetIt.instance;

void init() {
  registerCore();
  registerSessionHandler();
  registerMainActivity();
  registerProviderAvtivity();
}

void registerCore() {
  injector.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImplementation(
      injector(),
    ),
  );
  injector.registerLazySingleton(() => DataConnectionChecker());
  injector.registerLazySingleton(() => FirebaseAuth.instance);
  injector.registerLazySingleton(() => Firestore.instance);
  injector.registerLazySingleton(() => http.Client());
  injector.registerLazySingleton<SecureStore>(
    () => SecureStoreImplementation(
      storage: injector(),
    ),
  );
  injector.registerLazySingleton(() => FlutterSecureStorage());
}

void registerSessionHandler() {
  injector.registerFactory(
    () => SessionHandlerBloc(
      loginUseCase: injector(),
      logoutUseCase: injector(),
      checkIfLoggedInUseCase: injector(),
      signUpUseCase: injector(),
      waitingForEmailVerificationUseCase: injector(),
      resendVerificationEmailUseCase: injector(),
      updateUserProfileUseCase: injector(),
      checkAccountTypeUseCase: injector(),
      updateAccountTypeUseCase: injector(),
    ),
  );

  injector.registerLazySingleton(() => LoginUseCase(repository: injector()));
  injector.registerLazySingleton(() => LogoutUseCase(repository: injector()));
  injector.registerLazySingleton(
      () => CheckIfLoggedInUseCase(repository: injector()));
  injector.registerLazySingleton(() => SignUpUseCase(repository: injector()));
  injector.registerLazySingleton(
      () => WaitingForEmailVerificationUseCase(repository: injector()));
  injector.registerLazySingleton(
      () => ResendVerificationEmailUseCase(repository: injector()));
  injector.registerLazySingleton(
      () => UpdateUserProfileUseCase(repository: injector()));
  injector.registerLazySingleton<SessionHandlerRepository>(
    () => SessionHandlerRepositoryImplementation(
      networkInfo: injector(),
      remoteDataSource: injector(),
    ),
  );
  injector.registerLazySingleton(
      () => CheckAccountTypeUseCase(repository: injector()));
  injector.registerLazySingleton(
      () => UpdateAccountTypeUseCase(repository: injector()));
  injector.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImplementation(
        auth: injector(),
        secureStore: injector(),
        client: injector(),
        databaseReference: injector()),
  );
}

void registerMainActivity() {
  injector.registerFactory(
    () => MainActivityBloc(
        getUserModelDataUseCase: injector(),
        saveUserModelDataUseCase: injector()),
  );

  injector.registerLazySingleton(
      () => GetUserModelDataUseCase(repository: injector()));
  injector.registerLazySingleton(
      () => SaveUserModelDataUseCase(repository: injector()));

  injector.registerLazySingleton<MainActivityRepository>(() =>
      MainActivityRepositoryImplementation(
          networkInfo: injector(), mainActivityRemoteDataSource: injector()));

  injector.registerLazySingleton<MainActivityRemoteDataSource>(() =>
      MainActivityRemoteDataSourceImplementation(
          databaseReference: injector()));
}

void registerProviderAvtivity() {
  injector.registerFactory(() => ProviderActivityBloc(
      getRequiredDataListUseCase: injector(),
      saveRequiredDataListUseCase: injector()));

  injector.registerLazySingleton(
      () => GetRequiredDataListUseCase(repository: injector()));
  injector.registerLazySingleton(
      () => SaveRequiredDataListUseCase(repository: injector()));
  injector.registerLazySingleton<ProviderAvtivityRepository>(() =>
      ProviderActivityRepositoryImplementation(
          networkInfo: injector(),
          providerActivityRemoteDataSource: injector()));
  injector.registerLazySingleton<ProviderActivityRemoteDataSource>(() =>
      ProviderActivityRemoteDataSourceImplementation(
          databaseReference: injector()));
}
