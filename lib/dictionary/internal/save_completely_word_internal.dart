import 'package:words/dictionary/data/model/models.dart';
import 'package:words/dictionary/domain/error/failure_dictionary.dart';
import 'package:words/dictionary/data/datasource/save_completely_word_datasource.dart';

import '../../shared/services/hive_service.dart';


class SaveCountriesInternalDatasource implements ISaveCompleteWordDataSource {

  final HiveService hive;

  SaveCountriesInternalDatasource(this.hive);

  @override
  Future<bool> saveCompletelyWord(CompletelyWord completelyWord) async {
    try {
      final boxWordsCompletely = await hive.openBox(
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
