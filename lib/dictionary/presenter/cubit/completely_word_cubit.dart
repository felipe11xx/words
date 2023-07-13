import 'completely_word_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/services/auth_service.dart';
import '../../domain/error/failure_dictionary.dart';
import '../../../../shared/services/tts_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:words/dictionary/data/model/models.dart';
import 'package:words/dictionary/domain/usecase/do_get_completely_word_usecase.dart';
import '../../../user_favorites/domain/usecase/do_get_user_favorites_usecase.dart';
import 'package:words/dictionary/domain/usecase/do_save_completely_word_usecase.dart';
import 'package:words/user_favorites/domain/usecase/do_set_user_favorites_usecase.dart';

final $CompletelyWordCubit =
    Bind.singleton((i) => CompletelyWordCubit(i(), i(), i(), i(), i(), i()));

class CompletelyWordCubit extends Cubit<CompletelyWordState> {
  CompletelyWordCubit(
      this._wordUseCase,
      this._saveCompletelyWordUseCase,
      this.tts,
      this._setUserFavoritesUseCase,
      this._authServices,
      this._getUserFavoritesUseCase)
      : super(CompleteWordInitialState());

  final DoGetCompletelyWordUseCase _wordUseCase;
  final DoSaveCompletelyWordUseCase _saveCompletelyWordUseCase;
  final DoSetUserFavoritesUseCase _setUserFavoritesUseCase;
  final DoGetUserFavoritesUseCase _getUserFavoritesUseCase;
  final AuthService _authServices;


  final AppTTS tts;
  late List<String?> meanings;

  getCompletelyWord(String? word) async {
    emit(CompleteWordLoadingState(true));

    final result = await _wordUseCase.call(word);
     _isFavorite(word);
    result.fold(
      (l) => emit(CompleteWordErrorState(l as CompletelyWordDataSourceError)),
      (r) async {
        await _saveCompletelyWordUseCase.call(r);
        emit(
          CompleteWordSuccessState(r, _getMeanings(r), await _isFavorite(word)),
        );
      },
    );
  }

  speak(String word) => tts.speakEN(word);

  List<String?> _getMeanings(CompletelyWord completelyWord) {
    List<String?> meanings = [];
    completelyWord.results?.forEach((element) {
      meanings.add(element.definition);
    });

    return meanings;
  }

  Future<bool> _isFavorite(String? word) async {
    var result = await _getUserFavoritesUseCase.call(getUserId());
    bool isFavorite = false;
    result.fold((l) {
      isFavorite = false;
    }, (r) {
      isFavorite = r?.wordsFavorites.contains(word) ?? false;
    });
    return isFavorite;
  }

  setFavorites(String? word) {
    _setUserFavoritesUseCase.call(getUserId(), word);

  }

  String getUserId() {
    return _authServices.userAuth?.uid ?? '';
  }
}
