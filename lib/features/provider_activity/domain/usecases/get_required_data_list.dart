import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/domain/repositories/provider_activity_repository.dart';

class GetRequiredDataListUseCase {
  final ProviderAvtivityRepository repository;

  GetRequiredDataListUseCase({@required this.repository});

  Future<Either<Exception, List<String>>> call(
      {@required String userUID}) async {
    return await repository.getRequiredDataList(userUID: userUID);
  }
}
