import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'provider_activity_event.dart';
part 'provider_activity_state.dart';

class ProviderActivityBloc
    extends Bloc<ProviderActivityEvent, ProviderActivityState> {
  @override
  ProviderActivityState get initialState => ProviderWelcomePageState();

  @override
  Stream<ProviderActivityState> mapEventToState(
    ProviderActivityEvent event,
  ) async* {
    if (event is OpenProviderWelcomePage) {
      yield ProviderWelcomePageState();
    } else if (event is OpenProviderOptionsPage) {
      yield ProviderOptionsPageState();
    } else if (event is OpenProviderRequiredDataManager) {
      yield ProviderRequiredDataManagerState();
    }
  }
}
