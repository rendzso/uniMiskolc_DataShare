import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_miskolc_datashare/core/widgets/custom_input_field.dart';
import 'package:uni_miskolc_datashare/features/main_activity/presentation/widgets/drawer_menu.dart';
import 'package:uni_miskolc_datashare/features/session_handler/presentation/bloc/session_handler_bloc.dart';

class OptionsPage extends StatefulWidget {
  @override
  _OptionsPageState createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  FirebaseUser user;
  String newUserName;
  String newPhoneNumber;
  bool isEditable = false;
  bool changed = false;

  final myUserNameChangeController = TextEditingController();
  final myPhoneNumberChangeController = TextEditingController();

  @override
  void initState() {
    user = BlocProvider.of<SessionHandlerBloc>(context).state.props[0];
    newUserName = user.displayName.toString();
    newPhoneNumber = user.phoneNumber.toString();
    myUserNameChangeController.addListener(() {
      newUserName = myUserNameChangeController.text;
      checkIfDataChanged();
    });
    myPhoneNumberChangeController.addListener(() {
      newPhoneNumber = myPhoneNumberChangeController.text;
      checkIfDataChanged();
    });
    super.initState();
  }

  @override
  void dispose() {
    myUserNameChangeController.dispose();
    myPhoneNumberChangeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      drawer: DrawerMenu(),
      body: Container(
        child: Column(
          children: <Widget>[
            Text('Options page'),
            CustomInputField(
              myController: myUserNameChangeController,
              textHint: 'Display name',
              initialString:
                  user.displayName == null ? 'N/A' : user.displayName,
              isPassword: false,
              rowText: 'Display name:',
              onlyText: !isEditable,
            ),
            CustomInputField(
              myController: myPhoneNumberChangeController,
              textHint: 'Phone number verification isnt supported yet',
              initialString: 'Phone number verification isnt supported yet',
              isPassword: false,
              rowText: 'Phone number:',
              onlyText: true,
            ),
            CustomInputField(
              textHint: 'Email address',
              initialString: user.email == null ? 'N/A' : user.email,
              isPassword: false,
              rowText: 'Email:',
              onlyText: true,
            ),
            CustomInputField(
              initialString: user.isEmailVerified.toString(),
              isPassword: false,
              rowText: 'Email verified:',
              onlyText: true,
            ),
            Visibility(
              visible: isEditable,
              child: RaisedButton(
                child: Text('Resend email'),
                onPressed: user.isEmailVerified == true
                    ? null
                    : () {
                        BlocProvider.of<SessionHandlerBloc>(context)
                            .add(ResendVerificationEmail());
                      },
              ),
            ),
            Visibility(
              visible: isEditable,
              child: RaisedButton(
                child: Text('Save changes'),
                onPressed: changed
                    ? () {
                        BlocProvider.of<SessionHandlerBloc>(context).add(
                          UpdateUserProfile(
                              displayName: newUserName,
                              phoneNumber: 'newPhoneNumber'),
                        );
                      }
                    : null,
              ),
            ),
            Visibility(
              visible: !isEditable,
              replacement: RaisedButton(
                  child: Text('Back'),
                  onPressed: () {
                    setState(() {
                      isEditable = false;
                    });
                  }),
              child: RaisedButton(
                child: Text('Edit'),
                onPressed: () {
                  setState(() {
                    isEditable = true;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  checkIfDataChanged() {
    setState(() {
      if ((newUserName != '' && newUserName != user.displayName.toString()) ||
          (newPhoneNumber != '' &&
              newPhoneNumber != user.phoneNumber.toString())) {
        changed = true;
      } else {
        changed = false;
      }
    });
  }
}
