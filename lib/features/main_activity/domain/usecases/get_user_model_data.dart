import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/models/user_data_model.dart';
import 'package:uni_miskolc_datashare/features/main_activity/domain/repositories/main_activity_repository.dart';

class GetUserModelDataUseCase {
  final MainActivityRepository repository;

  GetUserModelDataUseCase({@required this.repository});

  Future<Either<Exception, UserDataModel>> call(
      {@required String userUID}) async {
    return await repository.getUserDataModel(userUID: userUID);
  }
}
