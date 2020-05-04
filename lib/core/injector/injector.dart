import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:uni_miskolc_datashare/core/network/network_info.dart';
import 'package:uni_miskolc_datashare/features/session_handler/data/datasources/remote_datasource.dart';
import 'package:uni_miskolc_datashare/features/session_handler/data/datasources/remote_datasource_impl.dart';
import 'package:uni_miskolc_datashare/features/session_handler/data/repositories/session_handler_repostiory_impl.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/repositories/session_handler_repository.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/login.dart';
import 'package:uni_miskolc_datashare/features/session_handler/presentation/bloc/session_handler_bloc.dart';

final injector = GetIt.instance;

void init() {
  registerSessionHandler();
  registerCore();
}

void registerCore() {
  injector.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImplementation(
      injector(),
    ),
  );
  injector.registerLazySingleton(() => DataConnectionChecker());
}

void registerSessionHandler() {
  injector.registerFactory(
    () => SessionHandlerBloc(
      loginUseCase: injector(),
    ),
  );

  injector.registerLazySingleton(() => LoginUseCase(repository: injector()));
  injector.registerLazySingleton<SessionHandlerRepository>(
    () => SessionHandlerRepositoryImplementation(
      networkInfo: injector(),
      remoteDataSource: injector(),
    ),
  );
  injector.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImplementation(),
  );
}
