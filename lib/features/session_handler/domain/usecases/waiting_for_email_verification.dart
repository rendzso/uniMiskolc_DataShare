import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/repositories/session_handler_repository.dart';

class WaitingForEmailVerificationUseCase{
  final SessionHandlerRepository repository;

  WaitingForEmailVerificationUseCase({@required this.repository});

  Future<Either<Exception, bool>> call() async {
    print('usecase?');
    return await repository.waitingForEmailVerification();
  }
}