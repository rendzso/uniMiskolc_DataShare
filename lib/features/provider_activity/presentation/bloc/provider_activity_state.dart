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

  QRCodeGeneratorState({@required this.requiredDataList});

  @override
  List<Object> get props => [this.requiredDataList];
}
