import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/models/client_subscribe_model.dart';

abstract class ProviderActivityRemoteDataSource {
  Future<List<String>> getRequiredDataList({@required String userUID});
  Future<bool> saveRequiredDataList(
      {String userUID, List<String> requiredDataList});
  Future<String> getFCMToken({@required String userUID});
  Future<void> sendQueueNumber(
      {@required ClientSubscribeModel clientSubscribeModel});
  Future<void> sendCallRequest(
      {@required String providerName,
      @required ClientSubscribeModel clientSubscribeModel});
}
