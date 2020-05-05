import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_miskolc_datashare/core/widgets/custom_input_field.dart';
import 'package:uni_miskolc_datashare/features/session_handler/presentation/bloc/session_handler_bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String email;
  String password;

  final myEmailChangeController = TextEditingController();
  final myPasswordChangeController = TextEditingController();

  @override
  void initState() {
    myEmailChangeController.addListener(() {
      email = myEmailChangeController.text;
    });
    myPasswordChangeController.addListener(() {
      password = myPasswordChangeController.text;
    });
    super.initState();
  }

  @override
  void dispose() {
    myEmailChangeController.dispose();
    myPasswordChangeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[400],
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 300,
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'LogIn Page',
                  style: TextStyle(fontSize: 30.0),
                ),
              ],
            ),
          ),
          CustomInputField(
            textHint: 'Email address',
            myController: myEmailChangeController,
            isPassword: false,
            rowText: 'Email:',
            onlyText: false,
          ),
          CustomInputField(
            textHint: 'Password',
            myController: myPasswordChangeController,
            isPassword: true,
            rowText: 'Password:',
            onlyText: false,
          ),
          RaisedButton(
              child: Text('Log In'),
              onPressed: () {
                BlocProvider.of<SessionHandlerBloc>(context).add(LogIn(
                  email: email,
                  password: password,
                ));
              }),
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: RaisedButton(
                child: Text('Sign up'),
                onPressed: () {
                  BlocProvider.of<SessionHandlerBloc>(context)
                      .add(OpenSignUpPage());
                }),
          ),
        ],
      ),
    );
  }
}
