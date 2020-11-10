import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/models/client_subscribe_model.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/models/provider_request_model.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/models/user_data_model.dart';
import 'package:uni_miskolc_datashare/features/main_activity/domain/usecases/get_fcm_token_client.dart';
import 'package:uni_miskolc_datashare/features/main_activity/domain/usecases/get_user_model_data.dart';
import 'package:uni_miskolc_datashare/features/main_activity/domain/usecases/save_user_model_data.dart';
import 'package:uni_miskolc_datashare/features/main_activity/domain/usecases/send_subscribe_data.dart';

part 'main_activity_event.dart';
part 'main_activity_state.dart';

class MainActivityBloc extends Bloc<MainActivityEvent, MainActivityState> {
  final GetUserModelDataUseCase getUserModelDataUseCase;
  final SaveUserModelDataUseCase saveUserModelDataUseCase;
  final SendSubscribeDataUseCase sendSubscribeDataUseCase;
  final GetFCMTokenUseCaseClient getFCMTokenUseCaseClient;

  MainActivityBloc({
    @required this.getUserModelDataUseCase,
    @required this.saveUserModelDataUseCase,
    @required this.sendSubscribeDataUseCase,
    @required this.getFCMTokenUseCaseClient,
  });

  @override
  MainActivityState get initialState => WelcomePageState();

  @override
  Stream<MainActivityState> mapEventToState(
    MainActivityEvent event,
  ) async* {
    if (event is OpenOptionsPage) {
      yield OptionsPageState();
    } else if (event is OpenWelcomePage) {
      yield WelcomePageState();
    } else if (event is OpenDataManagementPage) {
      final userModelDataOrException =
          await getUserModelDataUseCase(userUID: event.userUID);
      yield userModelDataOrException.fold(
          (error) => Error(message: 'Cant fetch user model data'),
          (userModelData) =>
              DataManagementPageState(userDataModel: userModelData));
    } else if (event is SaveUserModelData) {
      final savedOrException = await saveUserModelDataUseCase(
          userUID: event.userUID, userDataModel: event.userDataModel);
      yield savedOrException.fold(
          (error) => Error(message: 'Cant save user model data'),
          (okey) =>
              DataManagementPageState(userDataModel: event.userDataModel));
    } else if (event is OpenSubscribePage) {
      final userModelDataOrException =
          await getUserModelDataUseCase(userUID: event.userUID);
      final fcmTokenOrException =
          await getFCMTokenUseCaseClient(userUID: event.userUID);
      final token = fcmTokenOrException.fold((l) => null, (token) => token);
      yield userModelDataOrException.fold(
          (error) => Error(message: 'Cant fetch user model data'),
          (userModelData) => OpenSubscribePageState(
                userDataModel: userModelData,
                requestedData: event.requestedData,
                fcmToken: token,
              ));
    } else if (event is SaveSubscribeData) {
      await sendSubscribeDataUseCase(
          providerFCMToken: event.providerFCMToken,
          clientSubscribeModel: event.clientSubscribeModel);
      yield WelcomePageState();
    }
  }
}
