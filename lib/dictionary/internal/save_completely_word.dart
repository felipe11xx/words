import 'package:hive/hive.dart';
import 'package:flutter/cupertino.dart';
import 'package:words/dictionary/data/model/models.dart';
import 'package:words/all_words/data/model/user_history.dart';
import 'package:words/dictionary/domain/error/failure_dictionary.dart';
import 'package:words/dictionary/data/datasource/save_completely_word_datasource.dart';


class SaveCountriesDatasourceInternal implements ISaveCompleteWordDataSource {
  @override
  Future<bool> saveCompletelyWord(CompletelyWord completelyWord) async {
    try {
      final boxWordsCompletely = await Hive.openBox(
        'completelyWord', // Path where to store your boxes (Only used in Flutter / Dart IO)
      );
      boxWordsCompletely.put(completelyWord.word, completelyWord.toJson());

      String id = 'id'; //' AuthService().s ?? '';
      debugPrint('id == $id');

      // final userHistoricBox = await Hive.openBox('historicUser');
      //
      // final userHistory = userHistoricBox.get(id) as UserHistory?;
      // if (userHistory != null) {
      //
      //   if(!userHistory.wordHistory.contains(completelyWord.word)){
      //     List<String> upUserHistory = [
      //       ...userHistory.wordHistory,
      //       completelyWord.word ?? ''
      //     ];
      //     userHistoricBox.put(
      //         id, UserHistory(userId: id, wordHistory: upUserHistory));
      //   }
      //
      //   debugPrint('deu bom atualizar ${userHistory.wordHistory[0]}');
      //   debugPrint('deu bom atualizar ${userHistory.wordHistory.length}');
      // } else {
      //   userHistoricBox.put(id,
      //       UserHistory(userId: id, wordHistory: [completelyWord.word ?? '']));
      //   debugPrint('deu bom salvar');
      // }

      return true;
    } catch (e) {
      throw SaveCompletelyWordDataSourceError(
        message: e.toString(),
      );
    }
  }
}
