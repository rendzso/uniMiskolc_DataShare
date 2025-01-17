import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  Future<Either<Exception, FirebaseUser>> login(
      {String email, String password}) async {
    if (await networkInfo.isConnected) {
      try {
        final FirebaseUser answer = await remoteDataSource.login(
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
  Future<Either<Exception, bool>> logout() async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.logout();
        return Right(true);
      } on LogoutException {
        return Left(LogoutException());
      }
    } else {
      return Left(InternetException());
    }
  }

  @override
  Future<Either<Exception, FirebaseUser>> checkIfLoggedIn() async {
    if (await networkInfo.isConnected) {
      try {
        final answer = await remoteDataSource.checkIfLoggedIn();
        return Right(answer);
      } on LoginException {
        return Left(LoginException());
      }
    } else {
      return Left(InternetException());
    }
  }

  @override
  Future<Either<Exception, FirebaseUser>> signUp(
      {String email, String password}) async {
    if (await networkInfo.isConnected) {
      try {
        final answer =
            await remoteDataSource.signUp(email: email, password: password);
        return Right(answer);
      } on SignUpException {
        return Left(SignUpException());
      }
    } else {
      return Left(InternetException());
    }
  }

  @override
  Future<Either<Exception, bool>> waitingForEmailVerification() async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.waitingForEmailVerification();
        return Right(true);
      } on LoginException {
        return Left(LoginException());
      }
    } else {
      return Left(InternetException());
    }
  }

  Future<Either<Exception, bool>> resendVerificationEmail() async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.resendVerificationEmail();
        return Right(true);
      } on EmailResendException {
        return Left(EmailResendException());
      }
    } else {
      return Left(InternetException());
    }
  }

  Future<Either<Exception, bool>> updateUserData(
      {String displayname, String phoneNumber}) async {
    if (await networkInfo.isConnected) {
      try {
        final answer = await remoteDataSource.updateUserData(
            displayname: displayname, phoneNumber: phoneNumber);
        return Right(answer);
      } on UserProfileUpdateException {
        return Left(UserProfileUpdateException());
      }
    } else {
      return Left(InternetException());
    }
  }

  @override
  Future<Either<Exception, String>> getAccountType(
      {String userUID, String fcmToken}) async {
    if (await networkInfo.isConnected) {
      try {
        final answer = await remoteDataSource.checkAccountType(
            userUID: userUID, fcmToken: fcmToken);
        return Right(answer);
      } on CannotCheckAccountTypeException {
        return Left(CannotCheckAccountTypeException());
      }
    } else {
      return Left(LoginException());
    }
  }

  @override
  Future<Either<Exception, bool>> updateAccountType(
      {String userUID, String type}) async {
    if (await networkInfo.isConnected) {
      try {
        final answer = await remoteDataSource.updateAccountType(
            userUID: userUID, type: type);
        return Right(answer);
      } on CannotUpdateAccountTypeException {
        return Left(CannotUpdateAccountTypeException());
      }
    } else {
      return Left(InternetException());
    }
  }
}
