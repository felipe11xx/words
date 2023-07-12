import 'all_words_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/services/auth_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../domain/usecase/do_save_user_history_usecase.dart';
import '../../../../shared/services/real_time_data_base_service.dart';

final $AllWordsCubit = Bind.singleton((i) => AllWordsCubit(i(),i(), i()));

class AllWordsCubit extends Cubit<AllWordsState> {
  final RealTimeDataBaseService _realTimeDataBaseService;
  final DoSaveUserHistoryUseCase _doSaveUserHistoryUseCase;
  final AuthService _authServices;


  AllWordsCubit(this._realTimeDataBaseService,this._doSaveUserHistoryUseCase, this._authServices)
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


  saveUserHistory(String? word)async{

   await _doSaveUserHistoryUseCase.call( getUserId(), word);

  }

  String getUserId() {
    return _authServices.userAuth?.uid ?? '';
  }

}
