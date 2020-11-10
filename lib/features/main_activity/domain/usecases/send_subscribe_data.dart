import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/models/client_subscribe_model.dart';
import 'package:uni_miskolc_datashare/features/main_activity/domain/repositories/main_activity_repository.dart';

class SendSubscribeDataUseCase {
  final MainActivityRepository repository;

  SendSubscribeDataUseCase({@required this.repository});

  Future<Either<Exception, bool>> call(
      {@required String providerFCMToken,
      @required ClientSubscribeModel clientSubscribeModel}) async {
    return await repository.sendSubscribeData(
        providerFCMToken: providerFCMToken,
        clientSubscribeModel: clientSubscribeModel);
  }
}
