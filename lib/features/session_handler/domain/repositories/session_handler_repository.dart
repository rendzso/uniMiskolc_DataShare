import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

abstract class SessionHandlerRepository {
  Future<Either<Exception, bool>> login({@required String email,@required String password});
  Future<Either<Exception, bool>> logout();
}