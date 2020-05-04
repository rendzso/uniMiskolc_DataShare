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

class LogOut extends SessionHandlerEvent {
  @override
  List<Object> get props => null;
}
