import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class UserData extends Equatable {
  final String fistName;
  final String lastName;
  final String dateOfBirth;
  final String personalID;

  UserData({
    @required this.fistName,
    @required this.lastName,
    @required this.dateOfBirth,
    @required this.personalID,
  });

  @override
  List<Object> get props => [fistName, lastName, dateOfBirth, personalID];
}
