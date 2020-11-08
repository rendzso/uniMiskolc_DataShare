import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_miskolc_datashare/core/data/available_data.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/presentation/bloc/provider_activity_bloc.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/presentation/widgets/provider_drawer_menu.dart';
import 'package:uni_miskolc_datashare/features/session_handler/presentation/bloc/session_handler_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class QRCodeGenerator extends StatefulWidget {
  @override
  _QRCodeGeneratorState createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  final availableDataList = AvailableData().availableDataValue;
  final availableDataNameList = AvailableData().availableDataName;
  List<String> checkedDataList;
  FirebaseUser user;
  Uint8List bytes = Uint8List(200);
  bool qrVisible = false;

  @override
  void initState() {
    user = BlocProvider.of<SessionHandlerBloc>(context).state.props[0];
    checkedDataList =
        BlocProvider.of<ProviderActivityBloc>(context).state.props[0];
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
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            Text('Are you sure, want to create a QR code with these data?'),
            new ListView.builder(
                shrinkWrap: true,
                itemCount: checkedDataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Center(
                    child: Text(availableDataNameList[
                        availableDataList.indexOf(checkedDataList[index])]),
                  );
                }),
            RaisedButton(
                child: Text('Generate'),
                onPressed: () async {
                  Uint8List result =
                      await scanner.generateBarCode('alma vagyok hahaha');
                  setState(() {
                    bytes = result;
                    qrVisible = true;
                  });
                }),
            RaisedButton(
                child: Text('Save QR code'),
                onPressed: qrVisible
                    ? () async {
                        final success = await ImageGallerySaver.saveImage(bytes,
                            quality: 80, name: user.uid);
                        print(success);
                        SnackBar snackBar;
                        if (success != null) {
                          snackBar = new SnackBar(
                              content:
                                  new Text('Successful Saved to Gallery!'));
                          Scaffold.of(context).showSnackBar(snackBar);
                        } else {
                          snackBar =
                              new SnackBar(content: new Text('Save failed!'));
                        }
                      }
                    : null),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: qrVisible ? Image.memory(bytes) : Container(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
