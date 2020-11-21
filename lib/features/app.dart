import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uni_miskolc_datashare/core/injector/injector.dart';
import 'package:uni_miskolc_datashare/core/provider_queue/provider_queue.dart';
import 'package:uni_miskolc_datashare/core/user_serial_number/user_serial_number.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/data/datasources/provider_activity_remote_data_source.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/presentation/pages/provider_main.dart';
import 'package:uni_miskolc_datashare/features/session_handler/presentation/pages/account_type_changer.dart';
import 'package:uni_miskolc_datashare/features/session_handler/presentation/pages/login_form.dart';
import 'package:uni_miskolc_datashare/features/session_handler/presentation/pages/waiting_for_verification.dart';

import '../main.dart';
import 'main_activity/data/models/client_subscribe_model.dart';
import 'main_activity/presentation/pages/main.dart';
import 'session_handler/presentation/bloc/session_handler_bloc.dart';
import 'session_handler/presentation/pages/signup_form.dart';

class App extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorState =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      navigatorKey: App.navigatorState,
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

  void configureFireBaseMessagingManager(BuildContext context) {
    fireBaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onmessage');
        String title = message['notification']['title'].toString();
        String body = message['notification']['body'].toString();
        String data = '';

        if (message['data']['clientData'] != null) {
          data = message['data']['clientData'].toString();
          Map<String, dynamic> temp =
              json.decode(message['data']['clientData']);
          List<Map<String, String>> tempList = [];

          for (var index = 0;
              index < temp['requiredDataList'].length;
              index++) {
            String str = temp['requiredDataList'][index].toString();
            final cutKeyIndex = str.indexOf(':');
            final key = str.substring(1, cutKeyIndex);
            final value = str.substring(cutKeyIndex + 2, str.length - 1);
            tempList.add({key: value});
          }
          ClientSubscribeModel clientSubscribeModel = ClientSubscribeModel(
            userName: temp['userName'].toString(),
            userFCMToken: temp['userFCMToken'].toString(),
            requiredDataList: tempList,
          );
          injector.get<ProviderQueueStore>().addClient(clientSubscribeModel);
          List<ClientSubscribeModel> tempClienList =
              injector.get<ProviderQueueStore>().getClientList();
          injector
              .get<ProviderActivityRemoteDataSource>()
              .sendQueueNumber(clientSubscribeModel: tempClienList.last);
        }
        if (message['data']['providerData'] != null) {
          print('client kapott');
          Map<String, dynamic> temp =
              json.decode(message['data']['providerData']);
          if (temp['serialNumber'] != null) {
            print('serialnumber hozzáadva');

            injector
                .get<UserSerialNumber>()
                .addNumber(int.parse(temp['serialNumber']));
            print(injector.get<UserSerialNumber>().getNumber());
          } else if (temp['providerName'] != null) {
            injector.get<UserSerialNumber>().removeNumber();
          }
        }
        await popANotification(title, body, data);
      },
    );
  }

  Future<void> popANotification(
      String title, String body, String payload) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'your channel id', 'your channel name', 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: payload);
    setState(() {});
  }

  @override
  void initState() {
    fireBaseMessaging.getToken().then((value) => setToken(value));
    fireBaseMessaging.configure(
      onBackgroundMessage: myBackgroundMessageHandler,
    );
    configureFireBaseMessagingManager(context);
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
