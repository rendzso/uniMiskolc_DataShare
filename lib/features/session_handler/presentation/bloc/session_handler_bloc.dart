import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/login.dart';

part 'session_handler_event.dart';
part 'session_handler_state.dart';

class SessionHandlerBloc extends Bloc<SessionHandlerEvent, SessionHandlerState> {
  final LoginUseCase loginUseCase;

  SessionHandlerBloc({@required this.loginUseCase});
  @override
  SessionHandlerState get initialState => Empty();

  @override
  Stream<SessionHandlerState> mapEventToState(
    SessionHandlerEvent event,
  ) async* {
    if(event is LogIn){
      yield Loading();
      final loginOrException = await loginUseCase(email: event.email, password: event.password);
      yield loginOrException.fold((error) => Error(message: 'Something happened!'), (user) => Ready(user: user));
    }
  }
}
