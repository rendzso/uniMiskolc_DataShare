import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/datasources/main_activity_remote_datasource.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/models/user_data_model.dart';

class MainActivityRemoteDataSourceImplementation
    implements MainActivityRemoteDataSource {
  var databaseReference = Firestore.instance;

  MainActivityRemoteDataSourceImplementation(
      {@required this.databaseReference});
  @override
  Future<UserDataModel> fetchUserDataModel({String userUID}) async {
    final answer =
        await databaseReference.collection('userData').document(userUID).get();
    final UserDataModel userDataModel = UserDataModel.fromJson(answer.data);
    return userDataModel;
  }

  Future<void> addDataToDatabase(
      {String userUID, UserDataModel userData}) async {
    await databaseReference
        .collection('userData')
        .document(userUID)
        .setData(userData.toJson());
  }
}
