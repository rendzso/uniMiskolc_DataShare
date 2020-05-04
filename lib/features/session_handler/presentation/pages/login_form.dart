import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                Text('LogIn'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: 300,
              child: TextFormField(
                controller: myEmailChangeController,
                decoration: new InputDecoration(
                  hintText: 'Email address',
                  isDense: true,
                  contentPadding: EdgeInsets.all(6),
                  filled: true,
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: 300,
              child: TextFormField(
                controller: myPasswordChangeController,
                obscureText: true,
                decoration: new InputDecoration(
                  hintText: 'Password',
                  isDense: true,
                  contentPadding: EdgeInsets.all(6),
                  filled: true,
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: RaisedButton(
                child: Text('Log In'),
                onPressed: () {
                  BlocProvider.of<SessionHandlerBloc>(context).add(LogIn(
                    email: 'test@test.com',
                    password: 'testtest',
                  ));
                }),
          )
        ],
      ),
    );
  }
}
