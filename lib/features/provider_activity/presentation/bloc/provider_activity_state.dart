part of 'provider_activity_bloc.dart';

abstract class ProviderActivityState extends Equatable {
  const ProviderActivityState();
}

class ProviderWelcomePageState extends ProviderActivityState {
  @override
  List<Object> get props => null;
}

class ProviderOptionsPageState extends ProviderActivityState {
  @override
  List<Object> get props => null;
}

class ProviderRequiredDataManagerState extends ProviderActivityState {
  final List<String> requiredDataList;

  ProviderRequiredDataManagerState({@required this.requiredDataList});

  @override
  List<Object> get props => [this.requiredDataList];
}

class QRCodeGeneratorState extends ProviderActivityState {
  final List<String> requiredDataList;
  final String fcmToken;

  QRCodeGeneratorState(
      {@required this.requiredDataList, @required this.fcmToken});

  @override
  List<Object> get props => [this.requiredDataList, this.fcmToken];
}

class ShowQRCodePageState extends ProviderActivityState {
  @override
  List<Object> get props => null;
}
