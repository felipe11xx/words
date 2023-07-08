import '../model/models.dart';

abstract class IDoGetCompletelyWordDataSource {
  Future<WordCompleted> doGetCompletelyWord(String? word);

}