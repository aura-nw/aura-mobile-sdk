import 'package:flutter/material.dart';

import 'app_global_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppGlobalCubit extends Cubit<AppGlobalState> {
  AppGlobalCubit() : super(const AppGlobalState());

  void changeState(AppGlobalState newState) {
    assert(newState.status == AppGlobalStatus.authorized
        ? newState.auraWallet != null
        : newState.auraWallet == null);
    if (newState.status != state.status) {
      emit(newState);
    }
  }

  static AppGlobalCubit of(BuildContext context) => BlocProvider.of<AppGlobalCubit>(context);
}
