import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/repositories/session_handler_repository.dart';

class CheckAccountTypeUseCase {
  final SessionHandlerRepository repository;

  CheckAccountTypeUseCase({@required this.repository});

  Future<Either<Exception, String>> call({@required String userUID}) async {
    return await repository.getAccountType(userUID: userUID);
  }
}
