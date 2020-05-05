import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_miskolc_datashare/core/injector/injector.dart';
import 'package:uni_miskolc_datashare/features/session_handler/presentation/pages/login_form.dart';
import 'package:uni_miskolc_datashare/features/session_handler/presentation/pages/waiting_for_verification.dart';

import 'main_activity/presentation/pages/main.dart';
import 'session_handler/presentation/bloc/session_handler_bloc.dart';
import 'session_handler/presentation/pages/signup_form.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'UniMiskolc DataShare'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[400],
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: BlocProvider(
          create: (_) => injector<SessionHandlerBloc>(),
          child: BlocBuilder<SessionHandlerBloc, SessionHandlerState>(
              builder: (context, state) {
            if (state is Empty) {
              BlocProvider.of<SessionHandlerBloc>(context)
                  .add(CheckIfLoggedIn());
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LogInPage) {
              return LoginForm();
            } else if (state is Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoggedIn) {
              return Main();
            } else if (state is Error) {
              return Text(state.message);
            } else if (state is SignUpPage) {
              return SignUpForm();
            } else if (state is WaitingForEmailVerification) {
              return WaitingForEmailVerificationPage();
            }
          }),
        ));
  }
}
