import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/features/main_activity/domain/entities/provider_request.dart';

ProviderRequestDataModel parseUserData(String jsonResponse) {
  final decodedJson = json.decode(jsonResponse).cast<String, dynamic>();
  return decodedJson.map<ProviderRequestDataModel>(
      (element) => ProviderRequestDataModel.fromJson(element));
}

class ProviderRequestDataModel extends ProviderRequest {
  final String providerFCMToken;
  final String providerName;
  final List<String> requiredDataList;

  ProviderRequestDataModel({
    @required this.providerFCMToken,
    @required this.providerName,
    @required this.requiredDataList,
  });

  factory ProviderRequestDataModel.fromJson(Map<String, dynamic> mappedJson) {
    return ProviderRequestDataModel(
      providerFCMToken: mappedJson['providerFCMToken'],
      providerName: mappedJson['providerName'],
      requiredDataList: mappedJson['requiredDataList'].cast<String>(),
    );
  }

  toJson() {
    return {
      "providerUID": this.providerFCMToken,
      "providerName": this.providerName,
      "requiredDataList": this.requiredDataList,
    };
  }

  @override
  List<Object> get props => [providerFCMToken, providerName, requiredDataList];
}
