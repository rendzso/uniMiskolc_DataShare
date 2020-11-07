import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_miskolc_datashare/core/widgets/custom_input_field.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/models/user_data_model.dart';
import 'package:uni_miskolc_datashare/features/main_activity/presentation/bloc/main_activity_bloc.dart';
import 'package:uni_miskolc_datashare/features/main_activity/presentation/widgets/drawer_menu.dart';
import 'package:uni_miskolc_datashare/features/session_handler/presentation/bloc/session_handler_bloc.dart';

class DataManagement extends StatefulWidget {
  @override
  _DataManagementState createState() => _DataManagementState();
}

class _DataManagementState extends State<DataManagement> {
  final databaseReference = Firestore.instance;
  FirebaseUser user;
  UserDataModel userData;
  bool changed = false;

  final myFirstNameChangeController = TextEditingController();
  final myLastNameChangeController = TextEditingController();
  final myDateOfBirthChangeController = TextEditingController();
  final myPersonalIDChangeController = TextEditingController();
  String newFirstName;
  String newLastName;
  String newDateOfBirth;
  String newPersonalID;

  @override
  void initState() {
    user = BlocProvider.of<SessionHandlerBloc>(context).state.props[0];
    userData = BlocProvider.of<MainActivityBloc>(context).state.props[0];
    myFirstNameChangeController.addListener(() {
      newFirstName = myFirstNameChangeController.text;
      checkIfDataChanged();
    });
    myLastNameChangeController.addListener(() {
      newLastName = myLastNameChangeController.text;
      checkIfDataChanged();
    });
    myDateOfBirthChangeController.addListener(() {
      newDateOfBirth = myDateOfBirthChangeController.text;
      checkIfDataChanged();
    });
    myPersonalIDChangeController.addListener(() {
      newPersonalID = myPersonalIDChangeController.text;
      checkIfDataChanged();
    });
    super.initState();
  }

  @override
  void dispose() {
    myFirstNameChangeController.dispose();
    myLastNameChangeController.dispose();
    myDateOfBirthChangeController.dispose();
    myPersonalIDChangeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      drawer: DrawerMenu(),
      body: Column(
        children: <Widget>[
          Text('Data Management Page'),
          CustomInputField(
            myController: myFirstNameChangeController,
            textHint: userData.fistName,
            isPassword: false,
            rowText: 'First name:',
            onlyText: false,
          ),
          CustomInputField(
            myController: myLastNameChangeController,
            textHint: userData.lastName,
            isPassword: false,
            rowText: 'Last name:',
            onlyText: false,
          ),
          CustomInputField(
            myController: myDateOfBirthChangeController,
            textHint: userData.dateOfBirth,
            isPassword: false,
            rowText: 'Date of birth:',
            onlyText: false,
          ),
          CustomInputField(
            myController: myPersonalIDChangeController,
            textHint: userData.personalID,
            isPassword: false,
            rowText: 'Personal ID',
            onlyText: false,
          ),
          RaisedButton(
            child: Text('Save data'),
            onPressed: changed
                ? () {
                    BlocProvider.of<MainActivityBloc>(context).add(
                        SaveUserModelData(
                            userUID: user.uid,
                            userDataModel: getNewUserData()));
                  }
                : null,
          ),
          RaisedButton(
              child: Text('helper'),
              onPressed: () {
                print(user.runtimeType);
              }),
        ],
      ),
    );
  }

  getNewUserData() {
    final newUserData = UserDataModel(
        fistName: checkIfNewOrNotNull(userData.fistName, newFirstName)
            ? newFirstName
            : userData.fistName,
        lastName: checkIfNewOrNotNull(userData.lastName, newLastName)
            ? newLastName
            : userData.lastName,
        dateOfBirth: checkIfNewOrNotNull(userData.dateOfBirth, newDateOfBirth)
            ? newDateOfBirth
            : userData.dateOfBirth,
        personalID: checkIfNewOrNotNull(userData.personalID, newPersonalID)
            ? newPersonalID
            : userData.personalID);
    return newUserData;
  }

  checkIfNewOrNotNull(String oldData, String newData) {
    if (newData == '' || newData == null) {
      return false;
    } else if (newData == oldData) {
      return false;
    } else {
      return true;
    }
  }

  checkIfDataChanged() {
    setState(() {
      changed = userData.toString() != getNewUserData().toString();
    });
  }
}
