part of 'main_activity_bloc.dart';

abstract class MainActivityState extends Equatable {
  const MainActivityState();
}

class OptionsPageState extends MainActivityState {
  @override
  List<Object> get props => null;
}

class WelcomePageState extends MainActivityState {
  @override
  List<Object> get props => null;
}

class DataManagementPageState extends MainActivityState {
  final UserDataModel userDataModel;
  const DataManagementPageState({@required this.userDataModel});
  @override
  List<Object> get props => [this.userDataModel];
}

class Okay extends MainActivityState {
  final UserDataModel userDataModel;
  const Okay({@required this.userDataModel});

  @override
  List<Object> get props => [userDataModel];
}

class Error extends MainActivityState {
  final String message;
  const Error({@required this.message});

  @override
  List<Object> get props => [message];
}

class OpenSubscribePageState extends MainActivityState {
  final UserDataModel userDataModel;
  final ProviderRequestDataModel requestedData;
  final String fcmToken;

  OpenSubscribePageState(
      {@required this.userDataModel,
      @required this.requestedData,
      @required this.fcmToken});

  @override
  List<Object> get props =>
      [this.userDataModel, this.requestedData, this.fcmToken];
}
