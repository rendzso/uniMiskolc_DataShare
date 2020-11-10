import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ClientSubscribe extends Equatable {
  final String userName;
  final String userFCMToken;
  final List<Map<String, String>> requiredDataList;

  ClientSubscribe({
    @required this.userName,
    @required this.userFCMToken,
    @required this.requiredDataList,
  });

  @override
  List<Object> get props => [userName, userFCMToken, requiredDataList];

  @override
  bool get stringify => true;
}
