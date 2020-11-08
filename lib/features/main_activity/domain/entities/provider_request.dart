import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ProviderRequest extends Equatable {
  final String providerUID;
  final String providerName;
  final List<String> requiredDataList;

  ProviderRequest({
    @required this.providerUID,
    @required this.providerName,
    @required this.requiredDataList,
  });

  @override
  List<Object> get props => [providerUID, providerName, requiredDataList];

  @override
  bool get stringify => true;
}
