import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_miskolc_datashare/features/session_handler/presentation/bloc/session_handler_bloc.dart';

class AccountTypeChanger extends StatefulWidget {
  @override
  _AccountTypeChangerState createState() => _AccountTypeChangerState();
}

class _AccountTypeChangerState extends State<AccountTypeChanger> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[400],
      child: Column(
        children: <Widget>[
          Center(
            child: Column(
              children: [
                RaisedButton(
                    child: Text('Client'),
                    onPressed: () {
                      FirebaseUser user =
                          BlocProvider.of<SessionHandlerBloc>(context)
                              .state
                              .props[0];
                      BlocProvider.of<SessionHandlerBloc>(context)
                          .add(UpdateAccountType(user: user, type: 'client'));
                    }),
                RaisedButton(
                    child: Text('Provider'),
                    onPressed: () {
                      FirebaseUser user =
                          BlocProvider.of<SessionHandlerBloc>(context)
                              .state
                              .props[0];
                      BlocProvider.of<SessionHandlerBloc>(context)
                          .add(UpdateAccountType(user: user, type: 'provider'));
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
