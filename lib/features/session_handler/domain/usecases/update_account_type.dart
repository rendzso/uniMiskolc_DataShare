import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/repositories/session_handler_repository.dart';

class UpdateAccountTypeUseCase {
  final SessionHandlerRepository repository;

  UpdateAccountTypeUseCase({@required this.repository});

  Future<Either<Exception, bool>> call(
      {@required String userUID, @required String type}) async {
    return await repository.updateAccountType(userUID: userUID, type: type);
  }
}
