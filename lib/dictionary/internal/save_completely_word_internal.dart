import 'package:words/dictionary/data/model/models.dart';
import 'package:words/dictionary/domain/error/failure_dictionary.dart';
import 'package:words/dictionary/data/datasource/save_completely_word_datasource.dart';

import '../../shared/services/hive_service.dart';


class SaveCompleteWordInternalDatasource implements ISaveCompleteWordDataSource {

  final HiveService hive;

  SaveCompleteWordInternalDatasource(this.hive);

  @override
  Future<bool> saveCompletelyWord(CompletelyWord completelyWord) async {
    try {
      final boxWordsCompletely = await hive.openBox(
        'completelyWord',
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
