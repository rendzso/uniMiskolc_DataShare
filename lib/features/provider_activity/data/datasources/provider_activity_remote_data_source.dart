import 'package:flutter/foundation.dart';

abstract class ProviderActivityRemoteDataSource {
  Future<List<String>> getRequiredDataList({@required String userUID});
  Future<bool> saveRequiredDataList(
      {String userUID, List<String> requiredDataList});
}
