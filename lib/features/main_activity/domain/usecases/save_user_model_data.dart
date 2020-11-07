import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/models/user_data_model.dart';
import 'package:uni_miskolc_datashare/features/main_activity/domain/repositories/main_activity_repository.dart';

class SaveUserModelDataUseCase {
  final MainActivityRepository repository;

  SaveUserModelDataUseCase({@required this.repository});

  Future<Either<Exception, bool>> call(
      {@required String userUID, @required UserDataModel userDataModel}) async {
    return await repository.saveUserDataModel(
        userUID: userUID, userDataModel: userDataModel);
  }
}
