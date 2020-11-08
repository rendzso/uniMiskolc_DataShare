import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/core/errors/exceptions.dart';
import 'package:uni_miskolc_datashare/core/network/network_info.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/data/datasources/provider_activity_remote_data_source.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/domain/repositories/provider_activity_repository.dart';

class ProviderActivityRepositoryImplementation
    implements ProviderAvtivityRepository {
  final NetworkInfo networkInfo;
  final ProviderActivityRemoteDataSource providerActivityRemoteDataSource;

  ProviderActivityRepositoryImplementation(
      {@required this.networkInfo,
      @required this.providerActivityRemoteDataSource});

  @override
  Future<Either<Exception, List<String>>> getRequiredDataList(
      {String userUID}) async {
    if (await networkInfo.isConnected) {
      try {
        final List<String> requiredDataList =
            await providerActivityRemoteDataSource.getRequiredDataList(
          userUID: userUID,
        );
        return Right(requiredDataList);
      } on GetRequiredDataListException {
        return Left(GetRequiredDataListException());
      }
    } else {
      return Left(InternetException());
    }
  }

  @override
  Future<Either<Exception, bool>> saveRequiredDataList(
      {String userUID, List<String> requeredDataList}) async {
    if (await networkInfo.isConnected) {
      try {
        await providerActivityRemoteDataSource.saveRequiredDataList(
            userUID: userUID, requiredDataList: requeredDataList);
        return Right(true);
      } on SaveRequiredDataListException {
        return Left(SaveRequiredDataListException());
      }
    } else {
      return Left(InternetException());
    }
  }

  @override
  Future<Either<Exception, String>> getFCMToken({String userUID}) async {
    if (await networkInfo.isConnected) {
      try {
        final fcmToken = await providerActivityRemoteDataSource.getFCMToken(
            userUID: userUID);
        return Right(fcmToken);
      } on GetFCMTokenException {
        return Left(GetFCMTokenException());
      }
    } else {
      return Left(InternetException());
    }
  }
}
