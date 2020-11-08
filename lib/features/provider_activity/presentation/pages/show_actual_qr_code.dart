import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/presentation/widgets/provider_drawer_menu.dart';
import 'package:uni_miskolc_datashare/features/session_handler/presentation/bloc/session_handler_bloc.dart';

class ShowActualQRCode extends StatefulWidget {
  @override
  _ShowActualQRCodeState createState() => _ShowActualQRCodeState();
}

class _ShowActualQRCodeState extends State<ShowActualQRCode> {
  FirebaseUser user;
  File image;

  @override
  void initState() {
    user = BlocProvider.of<SessionHandlerBloc>(context).state.props[0];
    image = File('/storage/emulated/0/uni_miskolc_datashare/' +
                user.uid +
                '.jpg')
            .existsSync()
        ? File('/storage/emulated/0/uni_miskolc_datashare/' + user.uid + '.jpg')
        : null;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      drawer: ProviderDrawerMenu(),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            image != null
                ? Image.file(
                    image,
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                  )
                : Center(
                    child: Text('There are no saved QR code!'),
                  ),
          ]),
    );
  }
}
