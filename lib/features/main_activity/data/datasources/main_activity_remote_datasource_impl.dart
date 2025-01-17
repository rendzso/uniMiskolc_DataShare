import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:uni_miskolc_datashare/core/errors/exceptions.dart';
import 'package:uni_miskolc_datashare/core/secure_store/secure_store.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/datasources/main_activity_remote_datasource.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/models/client_subscribe_model.dart';
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
      if (answer.data == null) {
        return new UserDataModel(
            fistName: null,
            lastName: null,
            dateOfBirth: null,
            personalID: null);
      } else {
        final UserDataModel userDataModel = UserDataModel.fromJson(answer.data);
        return userDataModel;
      }
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

  @override
  Future<bool> sendSubscribeData(
      {String providerFCMToken,
      ClientSubscribeModel clientSubscribeModel}) async {
    try {
      String jsonClientSubscribeData = jsonEncode(clientSubscribeModel);
      String username = clientSubscribeModel.userName;
      String url = 'https://fcm.googleapis.com/fcm/send';
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json", // or whatever
        HttpHeaders.authorizationHeader:
            "key=AAAAPm9VB8w:APA91bHFA2shAWvAqynFAzYCuU5o_MbvGAOpGsfd4PZh1p6A_uHWEHNeRXG4rn87GiTZo9gsDrIt2FzyeQbNkFkmuZ_8aBxthNZJmzu5NHt-mTbZGJNuI1NCp95olMJVWUh28OujyQwq",
      };
      String json =
          '{"notification": {"body": "New clien arrived! Welcome ${username}","title": "New client!!!"},"data": { "clientData" : ${jsonClientSubscribeData}},"to": "${providerFCMToken}"}';
      // make POST request
      print(json);
      Response response = await post(url, headers: headers, body: json);
      // check the status code for the result
      int statusCode = response.statusCode;
      // this API passes back the id of the new item added to the body
      String body = response.body;
      print(body);
      print(statusCode);
      return true;
    } on PlatformException {
      throw SubscribeException();
    }
  }

  @override
  Future<String> getFCMToken({String userUID}) async {
    try {
      final fcmToken = await secureStore.getToken();
      return fcmToken;
    } on PlatformException {
      throw GetFCMTokenException();
    }
  }
}
