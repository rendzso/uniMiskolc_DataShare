import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uni_miskolc_datashare/core/injector/injector.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/presentation/bloc/provider_activity_bloc.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/presentation/pages/provider_options.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/presentation/pages/provider_queue_list.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/presentation/pages/provider_required_data_manager.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/presentation/pages/provider_welcome_page.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/presentation/pages/qr_code_generator.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/presentation/pages/show_actual_qr_code.dart';
import 'package:uni_miskolc_datashare/features/session_handler/presentation/bloc/session_handler_bloc.dart';

import '../../../../main.dart';

class ProviderMain extends StatefulWidget {
  @override
  _ProviderMainState createState() => _ProviderMainState();
}

class _ProviderMainState extends State<ProviderMain> {
  final fireBaseMessaging = FirebaseMessaging();
  FirebaseUser user;

  void configureFireBaseMessagingManager() {
    fireBaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('inMessage poppped');
        await popANotification();
      },
    );
  }

  Future<void> popANotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'your channel id', 'your channel name', 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');
  }

  @override
  void initState() {
    user = BlocProvider.of<SessionHandlerBloc>(context).state.props[0];
    configureFireBaseMessagingManager();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<ProviderActivityBloc>(),
      child: BlocBuilder<ProviderActivityBloc, ProviderActivityState>(
        builder: (context, state) {
          if (state is ProviderWelcomePageState) {
            return ProviderWelcomePage();
          } else if (state is ProviderOptionsPageState) {
            return ProviderOptionsPage();
          } else if (state is ProviderRequiredDataManagerState) {
            return ProviderRequiredDataManagement();
          } else if (state is QRCodeGeneratorState) {
            return QRCodeGenerator();
          } else if (state is ShowQRCodePageState) {
            return ShowActualQRCode();
          } else if (state is QueueListPageState) {
            return ProviderQueueList();
          }
        },
      ),
    );
  }
}
