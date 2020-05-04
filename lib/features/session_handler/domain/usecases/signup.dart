import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/repositories/session_handler_repository.dart';

class SignUpUseCase{
  final SessionHandlerRepository repository;

  SignUpUseCase({@required this.repository});

  Future<Either<Exception, FirebaseUser>> call({@required String email, @required String password}) async {
    return await repository.signUp(email: email, password: password);
  }
}