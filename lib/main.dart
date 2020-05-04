import 'package:flutter/material.dart';

import 'features/app.dart';

import 'core/injector/injector.dart' as injector;

Future<void> main() async {
  injector.init();

  runApp(App());
}
