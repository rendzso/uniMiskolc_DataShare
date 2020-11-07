import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_miskolc_datashare/core/injector/injector.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/presentation/bloc/provider_activity_bloc.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/presentation/pages/provider_options.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/presentation/pages/provider_required_data_manager.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/presentation/pages/provider_welcome_page.dart';
import 'package:uni_miskolc_datashare/features/session_handler/presentation/bloc/session_handler_bloc.dart';

class ProviderMain extends StatefulWidget {
  @override
  _ProviderMainState createState() => _ProviderMainState();
}

class _ProviderMainState extends State<ProviderMain> {
  FirebaseUser user;

  @override
  void initState() {
    user = BlocProvider.of<SessionHandlerBloc>(context).state.props[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<ProviderActivityBloc>(),
      child: BlocBuilder<ProviderActivityBloc, ProviderActivityState>(
        builder: (context, state) {
          if (state is ProviderWelcomePageState) {
            return ProviderWelcomePage();
          } else if (state is ProviderOptionsPageState) {
            return ProviderOptionsPage();
          } else if (state is ProviderRequiredDataManagerState) {
            return ProviderRequiredDataManagement();
          }
        },
      ),
    );
  }
}
