import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/check_if_logged_in.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/login.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/logout.dart';

part 'session_handler_event.dart';
part 'session_handler_state.dart';

class SessionHandlerBloc
    extends Bloc<SessionHandlerEvent, SessionHandlerState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final CheckIfLoggedInUseCase checkIfLoggedInUseCase;

  SessionHandlerBloc(
      {@required this.loginUseCase,
      @required this.logoutUseCase,
      @required this.checkIfLoggedInUseCase});
  @override
  SessionHandlerState get initialState => Empty();

  @override
  Stream<SessionHandlerState> mapEventToState(
    SessionHandlerEvent event,
  ) async* {
    if (event is LogIn) {
      yield Loading();
      final loginOrException =
          await loginUseCase(email: event.email, password: event.password);
      yield loginOrException.fold(
          (error) => Error(message: 'Error when logging in'),
          (user) => LoggedIn(user: user));
    } else if (event is LogOut) {
      yield Loading();
      final loggedOutOrException = await logoutUseCase();
      yield loggedOutOrException.fold(
          (error) => Error(message: 'Error when logged out'),
          (ok) => LogInPage());
    } else if (event is CheckIfLoggedIn) {
      yield Loading();
      final loggedInOrEception = await checkIfLoggedInUseCase();
      yield loggedInOrEception.fold(
          (no) => LogInPage(), (user) => LoggedIn(user: user));
    }
  }
}
