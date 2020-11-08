import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_miskolc_datashare/core/data/available_data.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/presentation/bloc/provider_activity_bloc.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/presentation/widgets/provider_drawer_menu.dart';
import 'package:uni_miskolc_datashare/features/session_handler/presentation/bloc/session_handler_bloc.dart';

class ProviderRequiredDataManagement extends StatefulWidget {
  @override
  _ProviderRequiredDataManagementState createState() =>
      _ProviderRequiredDataManagementState();
}

class _ProviderRequiredDataManagementState
    extends State<ProviderRequiredDataManagement> {
  final databaseReference = Firestore.instance;
  final availableDataList = AvailableData().availableDataValue;
  final availableDataNameList = AvailableData().availableDataName;
  List<String> checkedDataList;
  FirebaseUser user;

  @override
  void initState() {
    user = BlocProvider.of<SessionHandlerBloc>(context).state.props[0];
    checkedDataList =
        BlocProvider.of<ProviderActivityBloc>(context).state.props[0];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      drawer: ProviderDrawerMenu(),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            Text('Provider Required Data Management Page'),
            new ListView.builder(
                shrinkWrap: true,
                itemCount: availableDataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return new CheckboxListTile(
                      title: Text(availableDataNameList[index]),
                      value: checkedDataList.contains(availableDataList[index]),
                      onChanged: (newValue) {
                        setState(() {
                          if (newValue == true) {
                            checkedDataList.add(availableDataList[index]);
                          } else if (newValue == false) {
                            checkedDataList.remove(availableDataList[index]);
                          }
                        });
                      });
                }),
            RaisedButton(
                child: Text('Save changes'),
                onPressed: () {
                  setState(() {
                    BlocProvider.of<ProviderActivityBloc>(context).add(
                        SaveProviderRequiredData(
                            requiredData: checkedDataList, userUID: user.uid));
                  });
                }),
          ],
        ),
      ),
    );
  }
}
