import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/core/errors/exceptions.dart';
import 'package:uni_miskolc_datashare/core/network/network_info.dart';
import 'package:uni_miskolc_datashare/features/session_handler/data/datasources/remote_datasource.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/repositories/session_handler_repository.dart';

class SessionHandlerRepositoryImplementation
    implements SessionHandlerRepository {
  final NetworkInfo networkInfo;
  final RemoteDataSource remoteDataSource;

  SessionHandlerRepositoryImplementation({
    @required this.networkInfo,
    @required this.remoteDataSource,
  });

  @override
  Future<Either<Exception, bool>> login({String email, String password}) async {
    if (await networkInfo.isConnected) {
      try {
        final answer = await remoteDataSource.login(
          email: email,
          password: password,
        );
        return Right(answer);
      } on LoginException {
        return Left(LoginException());
      }
    } else {
      return Left(InternetException());
    }
  }

  @override
  Future<Either<Exception, bool>> logout() {
    // TODO: implement logout
    return null;
  }
}
