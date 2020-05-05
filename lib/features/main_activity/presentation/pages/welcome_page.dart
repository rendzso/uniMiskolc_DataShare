import 'package:flutter/material.dart';
import 'package:uni_miskolc_datashare/features/main_activity/presentation/widgets/drawer_menu.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      drawer: DrawerMenu(),
      body: Text('WelcomePage'),
    );
  }
}
