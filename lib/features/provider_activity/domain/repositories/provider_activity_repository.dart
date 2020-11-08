import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

abstract class ProviderAvtivityRepository {
  Future<Either<Exception, List<String>>> getRequiredDataList({@required String userUID});
  Future<Either<Exception, bool>> saveRequiredDataList({@required String userUID, @required List<String> requeredDataList});
}