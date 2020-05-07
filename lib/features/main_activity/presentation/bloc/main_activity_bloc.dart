import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_activity_event.dart';
part 'main_activity_state.dart';

class MainActivityBloc extends Bloc<MainActivityEvent, MainActivityState> {
  @override
  MainActivityState get initialState => WelcomePageState();

  @override
  Stream<MainActivityState> mapEventToState(
    MainActivityEvent event,
  ) async* {
    if(event is OpenOptionsPage) {
      yield OptionsPageState();
    } else if (event is OpenWelcomePage) {
      yield WelcomePageState();
    } else if( event is OpenDataManagementPage) {
      yield DataManagementPageState();
    }
  }
}
