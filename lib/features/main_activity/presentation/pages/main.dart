import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_miskolc_datashare/core/injector/injector.dart';
import 'package:uni_miskolc_datashare/features/main_activity/presentation/bloc/main_activity_bloc.dart';
import 'package:uni_miskolc_datashare/features/main_activity/presentation/pages/client_serial_number.dart';
import 'package:uni_miskolc_datashare/features/main_activity/presentation/pages/data_management.dart';
import 'package:uni_miskolc_datashare/features/main_activity/presentation/pages/options.dart';
import 'package:uni_miskolc_datashare/features/main_activity/presentation/pages/subscribe_page.dart';
import 'package:uni_miskolc_datashare/features/main_activity/presentation/pages/welcome_page.dart';
import 'package:uni_miskolc_datashare/features/session_handler/presentation/bloc/session_handler_bloc.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  FirebaseUser user;

  @override
  void initState() {
    user = BlocProvider.of<SessionHandlerBloc>(context).state.props[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<MainActivityBloc>(),
      child: BlocBuilder<MainActivityBloc, MainActivityState>(
        builder: (context, state) {
          if (state is WelcomePageState) {
            return WelcomePage();
          } else if (state is OptionsPageState) {
            return OptionsPage();
          } else if (state is DataManagementPageState) {
            return DataManagement();
          } else if (state is OpenSubscribePageState) {
            return SubscribePage();
          } else if (state is OpenClientSerialNumberState) {
            return ClientSerialNumberPage();
          }
        },
      ),
    );
  }
}
