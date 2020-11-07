part of 'session_handler_bloc.dart';

abstract class SessionHandlerEvent extends Equatable {
  const SessionHandlerEvent();
}

class LogIn extends SessionHandlerEvent {
  final String email;
  final String password;

  LogIn({@required this.email, @required this.password});
  @override
  List<Object> get props => [email, password];
}

class SignUp extends SessionHandlerEvent {
  final String email;
  final String password;

  SignUp({@required this.email, @required this.password});
  @override
  List<Object> get props => [email, password];
}

class UpdateUserProfile extends SessionHandlerEvent {
  final String displayName;
  final String phoneNumber;

  UpdateUserProfile({@required this.displayName, @required this.phoneNumber});
  @override
  List<Object> get props => [displayName, phoneNumber];
}

class LogOut extends SessionHandlerEvent {
  @override
  List<Object> get props => null;
}

class CheckIfLoggedIn extends SessionHandlerEvent {
  @override
  List<Object> get props => null;
}

class OpenSignUpPage extends SessionHandlerEvent {
  @override
  List<Object> get props => null;
}

class OpenLogInPage extends SessionHandlerEvent {
  @override
  List<Object> get props => null;
}

class ResendVerificationEmail extends SessionHandlerEvent {
  @override
  List<Object> get props => null;
}

class CheckAccountType extends SessionHandlerEvent {
  final FirebaseUser user;

  CheckAccountType({@required this.user});

  @override
  List<Object> get props => [this.user];
}

class UpdateAccountType extends SessionHandlerEvent {
  final FirebaseUser user;
  final String type;

  UpdateAccountType({@required this.user, @required this.type});

  @override
  List<Object> get props => [this.user, this.type];
}
