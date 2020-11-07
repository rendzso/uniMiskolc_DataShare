import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_miskolc_datashare/core/widgets/custom_input_field.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/presentation/widgets/provider_drawer_menu.dart';
import 'package:uni_miskolc_datashare/features/session_handler/presentation/bloc/session_handler_bloc.dart';

class ProviderOptionsPage extends StatefulWidget {
  @override
  _ProviderOptionsPageState createState() => _ProviderOptionsPageState();
}

class _ProviderOptionsPageState extends State<ProviderOptionsPage> {
  FirebaseUser user;
  String newUserName;
  bool isEditable = false;
  bool changed = false;

  final myUserNameChangeController = TextEditingController();

  @override
  void initState() {
    user = BlocProvider.of<SessionHandlerBloc>(context).state.props[0];
    newUserName = user.displayName.toString();
    myUserNameChangeController.addListener(() {
      newUserName = myUserNameChangeController.text;
      checkIfDataChanged();
    });
    super.initState();
  }

  @override
  void dispose() {
    myUserNameChangeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      drawer: ProviderDrawerMenu(),
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
      if ((newUserName != '' && newUserName != user.displayName.toString())) {
        changed = true;
      } else {
        changed = false;
      }
    });
  }
}
