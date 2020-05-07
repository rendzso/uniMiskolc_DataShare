import 'package:uni_miskolc_datashare/features/main_activity/data/models/user_data_model.dart';

abstract class MainActivityRemoteDataSource {
  Future<UserDataModel> readDatabase();
  Future<void> addDataToDatabase({UserDataModel userData});
}
