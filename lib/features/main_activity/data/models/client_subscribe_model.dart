import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/features/main_activity/domain/entities/client_subscribe.dart';

ClientSubscribeModel parseUserData(String jsonResponse) {
  final decodedJson = json.decode(jsonResponse).cast<String, dynamic>();
  return decodedJson.map<ClientSubscribeModel>(
      (element) => ClientSubscribeModel.fromJson(element));
}

class ClientSubscribeModel extends ClientSubscribe {
  final String userName;
  final String userFCMToken;
  final List<Map<String, String>> requiredDataList;

  ClientSubscribeModel({
    @required this.userName,
    @required this.userFCMToken,
    @required this.requiredDataList,
  });

  factory ClientSubscribeModel.fromJson(Map<String, dynamic> mappedJson) {
    return ClientSubscribeModel(
      userName: mappedJson['userName'],
      userFCMToken: mappedJson['userFCMToken'],
      requiredDataList:
          mappedJson['requiredDataList'].cast<Map<String, String>>(),
    );
  }

  toJson() {
    return {
      "userName": this.userName,
      "userFCMToken": this.userFCMToken,
      "requiredDataList": this.requiredDataList,
    };
  }

  @override
  List<Object> get props => [userName, userFCMToken, requiredDataList];
}
