import 'package:hive/hive.dart';
import 'package:words/dictionary/data/model/models.dart';
import 'package:words/dictionary/domain/error/failure_dictionary.dart';
import 'package:words/dictionary/data/datasource/save_completely_word_datasource.dart';


class SaveCountriesInternalDatasource implements ISaveCompleteWordDataSource {
  @override
  Future<bool> saveCompletelyWord(CompletelyWord completelyWord) async {
    try {
      final boxWordsCompletely = await Hive.openBox(
        'completelyWord', // Path where to store your boxes (Only used in Flutter / Dart IO)
      );
      boxWordsCompletely.put(completelyWord.word, completelyWord.toJson());

      return true;
    } catch (e) {
      throw SaveCompletelyWordDataSourceError(
        message: e.toString(),
      );
    }
  }
}
