import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/domain/repositories/provider_activity_repository.dart';

class SaveRequiredDataListUseCase {
  final ProviderAvtivityRepository repository;

  SaveRequiredDataListUseCase({@required this.repository});

  Future<Either<Exception, bool>> call(
      {@required String userUID,
      @required List<String> requiredDataList}) async {
    return await repository.saveRequiredDataList(
        userUID: userUID, requeredDataList: requiredDataList);
  }
}
