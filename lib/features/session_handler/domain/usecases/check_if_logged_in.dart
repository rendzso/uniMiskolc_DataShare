import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/repositories/session_handler_repository.dart';

class CheckIfLoggedInUseCase {
  final SessionHandlerRepository repository;

  CheckIfLoggedInUseCase({@required this.repository});

  Future<Either<Exception, FirebaseUser>> call() async {
    return await repository.checkIfLoggedIn();
  }
}
