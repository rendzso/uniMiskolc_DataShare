import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_miskolc_datashare/core/injector/injector.dart';
import 'package:uni_miskolc_datashare/features/main_activity/presentation/bloc/main_activity_bloc.dart';
import 'package:uni_miskolc_datashare/features/main_activity/presentation/pages/options.dart';
import 'package:uni_miskolc_datashare/features/main_activity/presentation/pages/welcome_page.dart';


class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => injector<MainActivityBloc>(),
        child: BlocBuilder<MainActivityBloc, MainActivityState>(
          builder: (context, state) {
            if (state is WelcomePageState) {
              return WelcomePage();
            } else if(state is OptionsPageState){
              return OptionsPage();
            }
          },
        ),
      );
  }
}
