import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/services/real_time_data_base_service.dart';
import 'all_words_state.dart';

final $AllWordsCubit = Bind.singleton((i) => AllWordsCubit(i()));

class AllWordsCubit extends Cubit<AllWordsState> {
  final RealTimeDataBaseService _realTimeDataBaseService;

  AllWordsCubit(this._realTimeDataBaseService)
      : super(AllWordsStateInitialState());


  getWords()async{
    emit(AllWordsStateLoadingState(true));


    var result = await _realTimeDataBaseService.getWords();


  }
}
