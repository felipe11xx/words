import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:words/all_words/domain/usecase/do_get_user_history_usecase.dart';

import '../../../shared/services/auth_service.dart';
import 'cubits.dart';

final $HistoryCubit = Bind.singleton((i) => HistoryCubit(i(),i()));

class HistoryCubit extends Cubit<HistoryState> {
  final DoGetUserHistoryUseCase _doGetUserHistoryUseCase;
  final AuthService _authServices;

  HistoryCubit(this._doGetUserHistoryUseCase,this._authServices)
      : super(HistoryInitialState());

  getWords() async {
    emit(HistoryLoadingState(true));

    try {
      var result = await _doGetUserHistoryUseCase.call(getUserId());

      emit(HistorySuccessState(result as List<String?>));
    } catch (e) {
      emit(HistoryErrorState(e as Exception));
    }
  }

  String getUserId() {
    return _authServices.userAuth?.uid ?? '';
  }

}