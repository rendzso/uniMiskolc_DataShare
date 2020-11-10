import 'package:flutter/material.dart';
import 'package:uni_miskolc_datashare/core/injector/injector.dart';
import 'package:uni_miskolc_datashare/core/user_serial_number/user_serial_number.dart';
import 'package:uni_miskolc_datashare/features/main_activity/presentation/widgets/drawer_menu.dart';

class ClientSerialNumberPage extends StatefulWidget {
  @override
  _ClientSerialNumberPageState createState() => _ClientSerialNumberPageState();
}

class _ClientSerialNumberPageState extends State<ClientSerialNumberPage> {
  int serialNumber;
  @override
  void initState() {
    serialNumber = injector.get<UserSerialNumber>().getNumber();
    print('UI number: $serialNumber');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      drawer: DrawerMenu(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          serialNumber == 0
              ? Center(
                  child: Text('You are not subscribed anywhere!'),
                )
              : Center(
                  child: Text('You are the $serialNumber in the line!'),
                )
        ],
      ),
    );
  }
}
