import 'package:hive/hive.dart';
import '../domain/error/failure_dictionary.dart';
import 'package:words/dictionary/data/model/completely_word.dart';
import 'package:words/dictionary/data/datasource/get_completely_word_datasource.dart';

class DoGetCompletelyWordInternalDatasource implements IDoGetCompletelyWordDataSource{
  DoGetCompletelyWordInternalDatasource();


  @override
  Future<CompletelyWord> doGetCompletelyWord(String? word) async{
    try {
      final boxWordsCompletely = await Hive.openBox('completelyWord');
      final completelyWord = await boxWordsCompletely.get(word);
      return CompletelyWord.fromJson(completelyWord);
    } catch (e) {
      throw CompletelyWordDataSourceError(message: e.toString(), );
    }
  }

}