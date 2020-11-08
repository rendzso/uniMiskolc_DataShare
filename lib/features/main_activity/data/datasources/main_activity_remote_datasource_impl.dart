import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:uni_miskolc_datashare/core/errors/exceptions.dart';
import 'package:uni_miskolc_datashare/core/secure_store/secure_store.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/datasources/main_activity_remote_datasource.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/models/user_data_model.dart';

class MainActivityRemoteDataSourceImplementation
    implements MainActivityRemoteDataSource {
  var databaseReference = Firestore.instance;
  final SecureStore secureStore;

  MainActivityRemoteDataSourceImplementation(
      {@required this.databaseReference, @required this.secureStore});
  @override
  Future<UserDataModel> fetchUserDataModel({String userUID}) async {
    try {
      final answer = await databaseReference
          .collection('userData')
          .document(userUID)
          .get();
      final UserDataModel userDataModel = UserDataModel.fromJson(answer.data);
      return userDataModel;
    } on PlatformException {
      throw InternetException();
    }
  }

  Future<bool> saveUserDataModel(
      {String userUID, UserDataModel userData}) async {
    try {
      await databaseReference
          .collection('userData')
          .document(userUID)
          .setData(userData.toJson());
      return true;
    } on PlatformException {
      throw InternetException();
    }
  }
}
