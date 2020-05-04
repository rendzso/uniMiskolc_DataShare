import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:uni_miskolc_datashare/core/network/network_info.dart';
import 'package:uni_miskolc_datashare/core/secure_store/secure_store.dart';
import 'package:uni_miskolc_datashare/core/secure_store/secure_store_impl.dart';
import 'package:uni_miskolc_datashare/features/session_handler/data/datasources/remote_datasource.dart';
import 'package:uni_miskolc_datashare/features/session_handler/data/datasources/remote_datasource_impl.dart';
import 'package:uni_miskolc_datashare/features/session_handler/data/repositories/session_handler_repostiory_impl.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/repositories/session_handler_repository.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/check_if_logged_in.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/login.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/logout.dart';
import 'package:uni_miskolc_datashare/features/session_handler/presentation/bloc/session_handler_bloc.dart';

final injector = GetIt.instance;

void init() {
  registerCore();
  registerSessionHandler();
}

void registerCore() {
  injector.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImplementation(
      injector(),
    ),
  );
  injector.registerLazySingleton(() => DataConnectionChecker());
  injector.registerLazySingleton(() => FirebaseAuth.instance);
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
    ),
  );

  injector.registerLazySingleton(() => LoginUseCase(repository: injector()));
  injector.registerLazySingleton(() => LogoutUseCase(repository: injector()));
  injector.registerLazySingleton(
      () => CheckIfLoggedInUseCase(repository: injector()));
  injector.registerLazySingleton<SessionHandlerRepository>(
    () => SessionHandlerRepositoryImplementation(
      networkInfo: injector(),
      remoteDataSource: injector(),
    ),
  );
  injector.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImplementation(
        auth: injector(), secureStore: injector(), client: injector()),
  );
}
