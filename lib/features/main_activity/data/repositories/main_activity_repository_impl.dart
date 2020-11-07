import 'package:flutter/cupertino.dart';
import 'package:uni_miskolc_datashare/core/errors/exceptions.dart';
import 'package:uni_miskolc_datashare/core/network/network_info.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/datasources/main_activity_remote_datasource.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/models/user_data_model.dart';
import 'package:dartz/dartz.dart';
import 'package:uni_miskolc_datashare/features/main_activity/domain/repositories/main_activity_repository.dart';

class MainActivityRepositoryImplementation implements MainActivityRepository {
  final NetworkInfo networkInfo;
  final MainActivityRemoteDataSource mainActivityRemoteDataSource;

  MainActivityRepositoryImplementation({
    @required this.networkInfo,
    @required this.mainActivityRemoteDataSource,
  });

  @override
  Future<Either<Exception, UserDataModel>> getUserDataModel(
      {String userUID}) async {
    if (await networkInfo.isConnected) {
      try {
        final UserDataModel userDataModel =
            await mainActivityRemoteDataSource.fetchUserDataModel(
          userUID: userUID,
        );
        return Right(userDataModel);
      } on LoginException {
        return Left(LoginException());
      }
    } else {
      return Left(InternetException());
    }
  }
}
