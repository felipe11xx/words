import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/services/auth_service.dart';
import '../../../../shared/services/real_time_data_base_service.dart';
import 'all_words_state.dart';

final $AllWordsCubit = Bind.singleton((i) => AllWordsCubit(i(), i()));

class AllWordsCubit extends Cubit<AllWordsState> {
  final RealTimeDataBaseService _realTimeDataBaseService;
  final AuthService _authServices;

  AllWordsCubit(this._realTimeDataBaseService, this._authServices)
      : super(AllWordsStateInitialState());

  getWords() async {
    emit(AllWordsStateLoadingState(true));

    try {
      var result = await _realTimeDataBaseService.getWords();
      emit(AllWordsSuccessState(result));
    } catch (e) {
      emit(AllWordsErrorState(e as Exception));
    }
  }

  signOut() async {
    try {
      await _authServices.signOut();
      emit(UserSignOutSuccessState());
    } on AuthException catch (e) {
      emit(UserSignOutErrorState(e));
    }
    await _authServices.signOut();
  }

  String? getUserEmail() {
    return _authServices.userAuth?.email;
  }
}
