import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_activity_event.dart';
part 'main_activity_state.dart';

class MainActivityBloc extends Bloc<MainActivityEvent, MainActivityState> {
  @override
  MainActivityState get initialState => MainActivityInitial();

  @override
  Stream<MainActivityState> mapEventToState(
    MainActivityEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
