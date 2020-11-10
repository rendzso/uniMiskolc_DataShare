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
      } on CannotFetchUserDataModelException {
        return Left(CannotFetchUserDataModelException());
      }
    } else {
      return Left(InternetException());
    }
  }

  @override
  Future<Either<Exception, bool>> saveUserDataModel(
      {String userUID, UserDataModel userDataModel}) async {
    if (await networkInfo.isConnected) {
      try {
        await mainActivityRemoteDataSource.saveUserDataModel(
            userUID: userUID, userData: userDataModel);
        return Right(true);
      } on CannotSaveUserDataModelException {
        return Left(CannotSaveUserDataModelException());
      }
    } else {
      return Left(InternetException());
    }
  }

  @override
  Future<Either<Exception, bool>> sendSubscribeData(
      {@required providerFCMToken, @required clientSubscribeModel}) async {
    if (await networkInfo.isConnected) {
      await mainActivityRemoteDataSource.sendSubscribeData(
          providerFCMToken: providerFCMToken,
          clientSubscribeModel: clientSubscribeModel);
      return Right(true);
    } else {
      return Left(InternetException());
    }
  }

  @override
  Future<Either<Exception, String>> getFCMToken({String userUID}) async {
    if (await networkInfo.isConnected) {
      try {
        final fcmToken =
            await mainActivityRemoteDataSource.getFCMToken(userUID: userUID);
        return Right(fcmToken);
      } on GetFCMTokenException {
        return Left(GetFCMTokenException());
      }
    } else {
      return Left(InternetException());
    }
  }
}
