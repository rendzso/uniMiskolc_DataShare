part of 'main_activity_bloc.dart';

abstract class MainActivityEvent extends Equatable {
  const MainActivityEvent();
}

class OpenOptionsPage extends MainActivityEvent{
  @override
  List<Object> get props => null;
}
class OpenWelcomePage extends MainActivityEvent{
  @override
  List<Object> get props => null;
}