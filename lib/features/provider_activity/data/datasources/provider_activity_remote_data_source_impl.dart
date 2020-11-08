import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:uni_miskolc_datashare/core/data/available_data.dart';
import 'package:uni_miskolc_datashare/core/errors/exceptions.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/data/datasources/provider_activity_remote_data_source.dart';

class ProviderActivityRemoteDataSourceImplementation
    implements ProviderActivityRemoteDataSource {
  var databaseReference = Firestore.instance;

  ProviderActivityRemoteDataSourceImplementation(
      {@required this.databaseReference});

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
}
