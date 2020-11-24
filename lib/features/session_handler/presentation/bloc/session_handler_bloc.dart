import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/models/user_data_model.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/chack_account_type.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/check_if_logged_in.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/login.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/logout.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/resend_verification_email.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/signup.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/update_account_type.dart';
import 'package:uni_miskolc_datashare/features/session_handler/domain/usecases/update_user_profile.dart';
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
  final ResendVerificationEmailUseCase resendVerificationEmailUseCase;
  final UpdateUserProfileUseCase updateUserProfileUseCase;
  final CheckAccountTypeUseCase checkAccountTypeUseCase;
  final UpdateAccountTypeUseCase updateAccountTypeUseCase;

  SessionHandlerBloc({
    @required this.loginUseCase,
    @required this.logoutUseCase,
    @required this.checkIfLoggedInUseCase,
    @required this.signUpUseCase,
    @required this.waitingForEmailVerificationUseCase,
    @required this.resendVerificationEmailUseCase,
    @required this.updateUserProfileUseCase,
    @required this.checkAccountTypeUseCase,
    @required this.updateAccountTypeUseCase,
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
      final verified = loginOrException.fold(
          (error) => null, (user) => user.isEmailVerified);
      if (verified != null && verified == false) {
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
      final verified = loggedInOrEception.fold(
          (error) => null, (user) => user.isEmailVerified);
      if (verified != null && verified == false) {
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
    } else if (event is ResendVerificationEmail) {
      resendVerificationEmailUseCase();
    } else if (event is UpdateUserProfile) {
      yield Loading();
      await updateUserProfileUseCase(
          displayname: event.displayName, phoneNumber: event.phoneNumber);
      final loggedInOrEception = await checkIfLoggedInUseCase();
      yield loggedInOrEception.fold(
          (no) => LogInPage(), (user) => LoggedIn(user: user));
    } else if (event is CheckAccountType) {
      final typeOrException = await checkAccountTypeUseCase(
          userUID: event.user.uid, fcmToken: event.fcmToken);
      final type = typeOrException.fold((error) => null, (type) => type);
      yield LoggedInWithType(user: event.user, type: type);
    } else if (event is UpdateAccountType) {
      yield Loading();
      final updatedOrException = await updateAccountTypeUseCase(
          userUID: event.user.uid, type: event.type);
      final updated =
          updatedOrException.fold((error) => false, (updated) => true);
      if (updated) {
        yield LoggedInWithType(user: event.user, type: event.type);
      }
    }
  }
}
