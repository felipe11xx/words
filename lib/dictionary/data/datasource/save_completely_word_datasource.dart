
import 'package:words/dictionary/data/model/models.dart';

abstract class ISaveCompleteWordDataSource {
  Future<bool> saveCompletelyWord(CompletelyWord completelyWord);
}