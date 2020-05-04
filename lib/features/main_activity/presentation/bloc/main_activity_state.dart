part of 'main_activity_bloc.dart';

abstract class MainActivityState extends Equatable {
  const MainActivityState();
}

class MainActivityInitial extends MainActivityState {
  @override
  List<Object> get props => [];
}
