import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/models/client_subscribe_model.dart';

import 'features/app.dart';

import 'core/injector/injector.dart' as injector;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}

Future<void> main() async {
  injector.init();
  WidgetsFlutterBinding.ensureInitialized();

  var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      Map<String, dynamic> temp = json.decode(payload);
      List<Map<String, String>> tempList = [];
      for (var index = 0; index < temp['requiredDataList'].length; index++) {
        String str = temp['requiredDataList'][index].toString();
        final cutKeyIndex = str.indexOf(':');
        final key = str.substring(1, cutKeyIndex);
        final value = str.substring(cutKeyIndex + 2, str.length - 1);
        tempList.add({key: value});
      }
      ClientSubscribeModel clientSubscribeModel = ClientSubscribeModel(
        userName: temp['userName'].toString(),
        userFCMToken: temp['userFCMToken'].toString(),
        requiredDataList: tempList,
      );
    }
  });
  runApp(App());
}
