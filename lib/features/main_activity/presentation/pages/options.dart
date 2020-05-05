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
              textHint: 'Email Address',
              initialString: user.email,
              isPassword: false,
              rowText: 'Email:',
            ),
          ],
        ),
      ),
    );
  }
}
