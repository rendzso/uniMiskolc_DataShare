part of 'session_handler_bloc.dart';

abstract class SessionHandlerState extends Equatable {
  const SessionHandlerState();
}

class Empty extends SessionHandlerState {
  @override
  List<Object> get props => [];
}

class LogInPage extends SessionHandlerState {
  @override
  List<Object> get props => [];
}

class SignUpPage extends SessionHandlerState {
  @override
  List<Object> get props => [];
}

class Loading extends SessionHandlerState {
  @override
  List<Object> get props => null;
}

class WaitingForEmailVerification extends SessionHandlerState {
  @override
  List<Object> get props => null;
}

class LoggedIn extends SessionHandlerState {
  final FirebaseUser user;
  const LoggedIn({@required this.user});

  @override
  List<Object> get props => [user];
}

class LoggedInWithType extends SessionHandlerState {
  final FirebaseUser user;
  final String type;
  const LoggedInWithType({@required this.user, @required this.type});

  @override
  List<Object> get props => [user, type];
}

class Error extends SessionHandlerState {
  final String message;
  const Error({@required this.message});

  @override
  List<Object> get props => [message];
}
