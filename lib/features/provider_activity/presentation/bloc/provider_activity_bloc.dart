import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/domain/usecases/get_fcm_token.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/domain/usecases/get_required_data_list.dart';
import 'package:uni_miskolc_datashare/features/provider_activity/domain/usecases/save_required_data_list.dart';

part 'provider_activity_event.dart';
part 'provider_activity_state.dart';

class ProviderActivityBloc
    extends Bloc<ProviderActivityEvent, ProviderActivityState> {
  final GetRequiredDataListUseCase getRequiredDataListUseCase;
  final SaveRequiredDataListUseCase saveRequiredDataListUseCase;
  final GetFCMTokenUseCase getFCMTokenUseCase;

  ProviderActivityBloc({
    @required this.getRequiredDataListUseCase,
    @required this.saveRequiredDataListUseCase,
    @required this.getFCMTokenUseCase,
  });

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
      final fcmTokenOrException =
          await getFCMTokenUseCase(userUID: event.userUID);
      final fcmToken =
          fcmTokenOrException.fold((error) => null, (token) => token);
      if (fcmToken != null) {
        yield requiredDataListOrException.fold(
            (error) => null,
            (list) => QRCodeGeneratorState(
                requiredDataList: list, fcmToken: fcmToken));
      }
    } else if (event is OpenShowQRCode) {
      yield ShowQRCodePageState();
    }
  }
}
