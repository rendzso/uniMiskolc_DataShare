import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:uni_miskolc_datashare/core/data/available_data.dart';
import 'package:uni_miskolc_datashare/core/errors/exceptions.dart';
import 'package:uni_miskolc_datashare/core/injector/injector.dart';
import 'package:uni_miskolc_datashare/core/provider_queue/provider_queue.dart';
import 'package:uni_miskolc_datashare/core/secure_store/secure_store.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/models/client_subscribe_model.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/data/datasources/provider_activity_remote_data_source.dart';

class ProviderActivityRemoteDataSourceImplementation
    implements ProviderActivityRemoteDataSource {
  var databaseReference = Firestore.instance;
  final SecureStore secureStore;

  ProviderActivityRemoteDataSourceImplementation(
      {@required this.databaseReference, @required this.secureStore});

  @override
  Future<List<String>> getRequiredDataList({String userUID}) async {
    try {
      List<String> returnList = [];
      final answer = await databaseReference
          .collection('requiredDataList')
          .document(userUID)
          .get();
      final answerList = answer.data;
      if (answerList == null) {
        return [];
      }
      for (var entity in answerList.entries) {
        if (entity.value == true) {
          returnList.add(entity.key);
        }
      }
      return returnList;
    } on PlatformException {
      throw GetRequiredDataListException();
    }
  }

  @override
  Future<bool> saveRequiredDataList(
      {String userUID, List<String> requiredDataList}) async {
    try {
      final availableDataList = AvailableData().availableDataValue;
      availableDataList.forEach((entry) async {
        await databaseReference
            .collection('requiredDataList')
            .document(userUID)
            .updateData({entry: requiredDataList.contains(entry)});
      });
      return true;
    } on PlatformException {
      throw SaveRequiredDataListException();
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

  @override
  Future<void> sendQueueNumber(
      {ClientSubscribeModel clientSubscribeModel}) async {
    try {
      String userFCMToken = clientSubscribeModel.userFCMToken;
      String url = 'https://fcm.googleapis.com/fcm/send';
      String serialNumber =
          (injector.get<ProviderQueueStore>().getClientList().length)
              .toString();
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json", // or whatever
        HttpHeaders.authorizationHeader:
            "key=AAAAPm9VB8w:APA91bHFA2shAWvAqynFAzYCuU5o_MbvGAOpGsfd4PZh1p6A_uHWEHNeRXG4rn87GiTZo9gsDrIt2FzyeQbNkFkmuZ_8aBxthNZJmzu5NHt-mTbZGJNuI1NCp95olMJVWUh28OujyQwq",
      };
      String json =
          '{"notification": {"body": "Successfully subscribed! You are the ${serialNumber}.","title": "Subscribed!!!"},"data": { "providerData" : { "serialNumber": "${serialNumber}"}},"to": "${userFCMToken}"}';
      // make POST request
      print(json);
      Response response = await post(url, headers: headers, body: json);
      // check the status code for the result
      int statusCode = response.statusCode;
      // this API passes back the id of the new item added to the body
      String body = response.body;
      print(body);
      print(statusCode);
    } on PlatformException {
      throw SubscribeException();
    }
  }

  @override
  Future<void> sendCallRequest(
      {String providerName, ClientSubscribeModel clientSubscribeModel}) async {
    try {
      String userFCMToken = clientSubscribeModel.userFCMToken;
      String url = 'https://fcm.googleapis.com/fcm/send';
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json", // or whatever
        HttpHeaders.authorizationHeader:
            "key=AAAAPm9VB8w:APA91bHFA2shAWvAqynFAzYCuU5o_MbvGAOpGsfd4PZh1p6A_uHWEHNeRXG4rn87GiTZo9gsDrIt2FzyeQbNkFkmuZ_8aBxthNZJmzu5NHt-mTbZGJNuI1NCp95olMJVWUh28OujyQwq",
      };
      String json =
          '{"notification": {"body": "${providerName} is calling you! Please come in!","title": "You are the next!"},"data": { "providerData" : { "providerName": "${providerName}"}},"to": "${userFCMToken}"}';
      // make POST request
      print(json);
      Response response = await post(url, headers: headers, body: json);
      // check the status code for the result
      int statusCode = response.statusCode;
      // this API passes back the id of the new item added to the body
      String body = response.body;
      print(body);
      print(statusCode);
    } on PlatformException {
      throw SubscribeException();
    }
  }
}
