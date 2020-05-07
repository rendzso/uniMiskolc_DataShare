import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/check_if_logged_in.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/login.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/logout.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/signup.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/waiting_for_email_verification.dart';

part 'session_handler_event.dart';
part 'session_handler_state.dart';

class SessionHandlerBloc
    extends Bloc<SessionHandlerEvent, SessionHandlerState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final CheckIfLoggedInUseCase checkIfLoggedInUseCase;
  final SignUpUseCase signUpUseCase;
  final WaitingForEmailVerificationUseCase waitingForEmailVerificationUseCase;

  SessionHandlerBloc({
    @required this.loginUseCase,
    @required this.logoutUseCase,
    @required this.checkIfLoggedInUseCase,
    @required this.signUpUseCase,
    @required this.waitingForEmailVerificationUseCase,
  });

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
      final verified = loginOrException.fold((error) => null, (user) => user.isEmailVerified);
      if (verified !=null && verified == false){
        yield WaitingForEmailVerification();
        await waitingForEmailVerificationUseCase();
      }
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
      final verified = loggedInOrEception.fold((error) => null, (user) => user.isEmailVerified);
      if (verified !=null && verified == false){
        yield WaitingForEmailVerification();
        await waitingForEmailVerificationUseCase();
      }
      yield loggedInOrEception.fold(
          (no) => LogInPage(), (user) => LoggedIn(user: user));
    } else if (event is OpenSignUpPage) {
      yield SignUpPage();
    } else if (event is OpenLogInPage) {
      yield LogInPage();
    } else if (event is SignUp) {
      yield WaitingForEmailVerification();
      final signedUpOrException =
          await signUpUseCase(email: event.email, password: event.password);
      yield signedUpOrException.fold(
        (error) => Error(message: 'Cant signUp'),
        (newUser) => LoggedIn(user: newUser),
      );
    }
  }
}
