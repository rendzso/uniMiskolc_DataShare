part of 'session_handler_bloc.dart';

abstract class SessionHandlerState extends Equatable {
  const SessionHandlerState();
}

class Empty extends SessionHandlerState {
  @override
  List<Object> get props => [];
}

class Loading extends SessionHandlerState{
  const Loading();

  @override
  List<Object> get props => null; 
}

class Ready extends SessionHandlerState{
  const Ready();

  @override
  List<Object> get props => null;
}

class Error extends SessionHandlerState{
  final String message;
  const Error({@required this.message});

  @override
  List<Object> get props => [message];
}
