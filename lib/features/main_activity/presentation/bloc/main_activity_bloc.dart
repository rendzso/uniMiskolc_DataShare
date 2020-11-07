import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:uni_miskolc_datashare/features/main_activity/data/models/user_data_model.dart';
import 'package:uni_miskolc_datashare/features/main_activity/domain/usecases/get_user_model_data.dart';

part 'main_activity_event.dart';
part 'main_activity_state.dart';

class MainActivityBloc extends Bloc<MainActivityEvent, MainActivityState> {
  final GetUserModelDataUseCase getUserModelDataUseCase;

  MainActivityBloc({
    @required this.getUserModelDataUseCase,
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
    }
  }
}
