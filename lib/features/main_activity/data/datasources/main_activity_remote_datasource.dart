import 'package:uni_miskolc_datashare/features/main_activity/data/models/user_data_model.dart';

abstract class MainActivityRemoteDataSource {
  Future<UserDataModel> fetchUserDataModel({String userUID});
  Future<bool> saveUserDataModel({String userUID, UserDataModel userData});
}
