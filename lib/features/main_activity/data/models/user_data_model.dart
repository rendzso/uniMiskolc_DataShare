import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/features/main_activity/domain/entities/user_data.dart';

UserDataModel parseUserData(String jsonResponse) {
  final decodedJson = json.decode(jsonResponse).cast<String, dynamic>();
  return decodedJson
      .map<UserDataModel>((element) => UserDataModel.fromJson(element));
}

class UserDataModel extends UserData {
  final String fistName;
  final String lastName;
  final String dateOfBirth;
  final String personalID;

  UserDataModel({
    @required this.fistName,
    @required this.lastName,
    @required this.dateOfBirth,
    @required this.personalID,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> mappedJson) {
    return UserDataModel(
      fistName: mappedJson['firstName'],
      lastName: mappedJson['lastName'],
      dateOfBirth: mappedJson['dateOfBirth'],
      personalID: mappedJson['personalID'],
    );
  }

  toJson() {
    return {
      "firstName": this.fistName,
      "lastName": this.lastName,
      "dateOfBirth": this.dateOfBirth,
      "personalID": this.personalID,
    };
  }

  @override
  List<Object> get props => [fistName, lastName, dateOfBirth, personalID];
}
