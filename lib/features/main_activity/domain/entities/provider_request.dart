import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ProviderRequest extends Equatable {
  final String providerFCMToken;
  final String providerName;
  final List<String> requiredDataList;

  ProviderRequest({
    @required this.providerFCMToken,
    @required this.providerName,
    @required this.requiredDataList,
  });

  @override
  List<Object> get props => [providerFCMToken, providerName, requiredDataList];

  @override
  bool get stringify => true;
}
