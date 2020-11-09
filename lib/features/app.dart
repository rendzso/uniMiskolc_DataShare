import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_miskolc_datashare/core/injector/injector.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/presentation/pages/provider_main.dart';
import 'package:uni_miskolc_datashare/features/session_handler/presentation/pages/account_type_changer.dart';
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

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
    print(data);
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
    print(notification);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final fireBaseMessaging = FirebaseMessaging();
  String fcmToken;

  void setToken(token) {
    fcmToken = token;
  }

  @override
  void initState() {
    fireBaseMessaging.getToken().then((value) => setToken(value));
    fireBaseMessaging.configure(
      onBackgroundMessage: myBackgroundMessageHandler,
    );
    super.initState();
  }

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
              BlocProvider.of<SessionHandlerBloc>(context).add(CheckAccountType(
                  user: BlocProvider.of<SessionHandlerBloc>(context)
                      .state
                      .props[0],
                  fcmToken: fcmToken));
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is Error) {
              return Text(state.message);
            } else if (state is SignUpPage) {
              return SignUpForm();
            } else if (state is WaitingForEmailVerification) {
              return WaitingForEmailVerificationPage();
            } else if (state is LoggedInWithType) {
              switch (
                  BlocProvider.of<SessionHandlerBloc>(context).state.props[1]) {
                case 'null':
                  {
                    return AccountTypeChanger();
                  }
                  break;
                case 'client':
                  {
                    return Main();
                  }
                  break;
                case 'provider':
                  {
                    return ProviderMain();
                  }
                  break;
                default:
                  {
                    return AccountTypeChanger();
                  }
              }
            }
          }),
        ));
  }
}
