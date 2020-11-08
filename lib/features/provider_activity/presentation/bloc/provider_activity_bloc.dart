import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/domain/usecases/get_required_data_list.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/domain/usecases/save_required_data_list.dart';

part 'provider_activity_event.dart';
part 'provider_activity_state.dart';

class ProviderActivityBloc
    extends Bloc<ProviderActivityEvent, ProviderActivityState> {
  final GetRequiredDataListUseCase getRequiredDataListUseCase;
  final SaveRequiredDataListUseCase saveRequiredDataListUseCase;

  ProviderActivityBloc(
      {@required this.getRequiredDataListUseCase,
      @required this.saveRequiredDataListUseCase});

  @override
  ProviderActivityState get initialState => ProviderWelcomePageState();

  @override
  Stream<ProviderActivityState> mapEventToState(
    ProviderActivityEvent event,
  ) async* {
    if (event is OpenProviderWelcomePage) {
      yield ProviderWelcomePageState();
    } else if (event is OpenProviderOptionsPage) {
      yield ProviderOptionsPageState();
    } else if (event is OpenProviderRequiredDataManager) {
      final requiredDataListOrException =
          await getRequiredDataListUseCase(userUID: event.userUID);
      yield requiredDataListOrException.fold((error) => null,
          (list) => ProviderRequiredDataManagerState(requiredDataList: list));
    } else if (event is SaveProviderRequiredData) {
      final savedOrException = await saveRequiredDataListUseCase(
          userUID: event.userUID, requiredDataList: event.requiredData);
      yield savedOrException.fold(
          (error) => null,
          (okey) => ProviderRequiredDataManagerState(
              requiredDataList: event.requiredData));
    } else if (event is OpenQRCodeGenerator) {
      final requiredDataListOrException =
          await getRequiredDataListUseCase(userUID: event.userUID);
      yield requiredDataListOrException.fold((error) => null,
          (list) => QRCodeGeneratorState(requiredDataList: list));
    }
  }
}
