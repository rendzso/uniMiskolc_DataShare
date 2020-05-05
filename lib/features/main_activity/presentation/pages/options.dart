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
  bool isEditable = false;

  @override
  void initState() {
    user = BlocProvider.of<SessionHandlerBloc>(context).state.props[0];
    super.initState();
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
              textHint: 'Display name',
              initialString:
                  user.displayName == null ? 'N/A' : user.displayName,
              isPassword: false,
              rowText: 'Display name:',
              onlyText: !isEditable,
            ),
            CustomInputField(
              textHint: 'Phone number',
              initialString:
                  user.phoneNumber == null ? 'N/A' : user.phoneNumber,
              isPassword: false,
              rowText: 'Phone number:',
              onlyText: !isEditable,
            ),
            CustomInputField(
              textHint: 'Email address',
              initialString: user.email == null ? 'N/A' : user.email,
              isPassword: false,
              rowText: 'Email:',
              onlyText: !isEditable,
            ),
            CustomInputField(
              initialString: user.isEmailVerified.toString(),
              isPassword: false,
              rowText: 'Email verified:',
              onlyText: true,
            ),
            RaisedButton(
              child: Text('Edit'),
              onPressed: () {
                print(user);
                setState(() {
                  isEditable = true;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
