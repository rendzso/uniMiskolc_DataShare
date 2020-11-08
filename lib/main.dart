import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'features/app.dart';

import 'core/injector/injector.dart' as injector;

Future<void> main() async {
  injector.init();
  runApp(App());
}
