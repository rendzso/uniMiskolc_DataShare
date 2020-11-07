import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/models/user_data_model.dart';

abstract class MainActivityRepository {
  Future<Either<Exception, UserDataModel>> getUserDataModel(
      {@required String userUID});
  Future<Either<Exception, bool>> saveUserDataModel(
      {@required String userUID, @required UserDataModel userDataModel});
}
