import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/datasources/main_activity_remote_datasource.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/models/user_data_model.dart';

class MainActivityRemoteDataSourceImplementation
    implements MainActivityRemoteDataSource {
  final FirebaseDatabase firebaseDataBase;

  MainActivityRemoteDataSourceImplementation({@required this.firebaseDataBase});
  @override
  Future<UserDataModel> readDatabase() {
    Query _userDataQuery = firebaseDataBase.reference().child("UserData");
  }

  Future<void> addDataToDatabase({UserDataModel userData}) {
    firebaseDataBase
        .reference()
        .child("UserData")
        .push()
        .set(userData.toJson());
  }
}
