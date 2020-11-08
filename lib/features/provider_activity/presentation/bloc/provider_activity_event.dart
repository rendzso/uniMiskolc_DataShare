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
  final String userUID;
  OpenProviderRequiredDataManager({@required this.userUID});
  @override
  List<Object> get props => [this.userUID];
}

class SaveProviderRequiredData extends ProviderActivityEvent {
  final String userUID;
  final List<String> requiredData;

  SaveProviderRequiredData(
      {@required this.requiredData, @required this.userUID});

  @override
  List<Object> get props => [this.requiredData, this.userUID];
}
