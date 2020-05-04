import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_miskolc_datashare/features/main_activity/presentation/widgets/drawer_menu.dart';
import 'package:uni_miskolc_datashare/features/session_handler/presentation/bloc/session_handler_bloc.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      body: RaisedButton(
          child: Text('LogOut'),
          onPressed: () {
            BlocProvider.of<SessionHandlerBloc>(context).add(LogOut());
          }),
    );
  }
}
