import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/repositories/session_handler_repository.dart';

class LogoutUseCase{
  final SessionHandlerRepository repository;

  LogoutUseCase({@required this.repository});

  Future<Either<Exception, bool>> call() async {
    return await repository.logout();
  }
}