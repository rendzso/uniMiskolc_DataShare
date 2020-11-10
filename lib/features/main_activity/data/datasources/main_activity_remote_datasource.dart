import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/models/client_subscribe_model.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/models/user_data_model.dart';

abstract class MainActivityRemoteDataSource {
  Future<UserDataModel> fetchUserDataModel({String userUID});
  Future<bool> saveUserDataModel({String userUID, UserDataModel userData});
  Future<bool> sendSubscribeData(
      {String providerFCMToken, ClientSubscribeModel clientSubscribeModel});
  Future<String> getFCMToken({@required String userUID});
}
