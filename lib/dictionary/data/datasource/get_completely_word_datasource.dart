import '../model/models.dart';

abstract class IDoGetCompletelyWordDataSource {
  Future<CompletelyWord> doGetCompletelyWord(String? word);
}