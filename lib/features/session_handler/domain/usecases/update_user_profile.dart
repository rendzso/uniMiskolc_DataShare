import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/repositories/session_handler_repository.dart';

class UpdateUserProfileUseCase{
  final SessionHandlerRepository repository;

  UpdateUserProfileUseCase({@required this.repository});

  Future<Either<Exception, bool>> call({String displayname, String phoneNumber}) async {
    return await repository.updateUserData(displayname: displayname, phoneNumber: phoneNumber);
  }
}