import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/presentation/widgets/provider_drawer_menu.dart';
import 'package:uni_miskolc_datashare/features/session_handler/presentation/bloc/session_handler_bloc.dart';

class ProviderQueueList extends StatefulWidget {
  @override
  _ProviderQueueListState createState() => _ProviderQueueListState();
}

class _ProviderQueueListState extends State<ProviderQueueList> {
  FirebaseUser user;
  String name;
  @override
  void initState() {
    user = BlocProvider.of<SessionHandlerBloc>(context).state.props[0];
    name = user.displayName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      drawer: ProviderDrawerMenu(),
      body: Center(
          child:
              Text('This is the queue list, and the data what received is: ')),
    );
  }
}
