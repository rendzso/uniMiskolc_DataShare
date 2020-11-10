import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/domain/repositories/provider_activity_repository.dart';

class GetFCMTokenUseCaseClient {
  final ProviderAvtivityRepository repository;

  GetFCMTokenUseCaseClient({@required this.repository});

  Future<Either<Exception, String>> call({@required String userUID}) async {
    return await repository.getFCMToken(userUID: userUID);
  }
}
