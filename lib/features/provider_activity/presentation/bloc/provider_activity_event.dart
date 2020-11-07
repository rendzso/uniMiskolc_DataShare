part of 'provider_activity_bloc.dart';

abstract class ProviderActivityEvent extends Equatable {
  const ProviderActivityEvent();
}

class OpenProviderOptionsPage extends ProviderActivityEvent {
  @override
  List<Object> get props => null;
}

class OpenProviderWelcomePage extends ProviderActivityEvent {
  @override
  List<Object> get props => null;
}

class OpenProviderRequiredDataManager extends ProviderActivityEvent {
  @override
  List<Object> get props => null;
}

class SaveProviderRequiredData extends ProviderActivityEvent {
  final List<String> requiredData;

  SaveProviderRequiredData({@required this.requiredData});

  @override
  List<Object> get props => [this.requiredData];
}
