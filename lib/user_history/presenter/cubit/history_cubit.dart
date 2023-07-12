import '../../../all_words/presenter/cubit/cubits.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/services/auth_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:words/user_history/domain/error/failure_user_history.dart';
import 'package:words/user_history/domain/usecase/do_get_user_history_usecase.dart';

final $HistoryCubit = Bind.singleton((i) => HistoryCubit(i(), i()));

class HistoryCubit extends Cubit<HistoryState> {
  final DoGetUserHistoryUseCase _doGetUserHistoryUseCase;
  final AuthService _authServices;

  HistoryCubit(this._doGetUserHistoryUseCase, this._authServices)
      : super(HistoryInitialState());

  getWords() async {
    emit(HistoryLoadingState(true));

    var result = await _doGetUserHistoryUseCase.call(getUserId());

    result.fold((l) =>
        emit(HistoryErrorState(l as UserHistoryDataSourceError)),
          (r) {
              if(r == null){
                emit(HistoryEmptyState(true));
              }else{
                emit(HistorySuccessState(r.wordHistory ));
              }

          }
        );
  }

  String getUserId() {
    return _authServices.userAuth?.uid ?? '';
  }

}