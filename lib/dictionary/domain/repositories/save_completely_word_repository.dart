import 'package:dartz/dartz.dart';
import '../error/failure_dictionary.dart';
import 'package:words/dictionary/data/model/models.dart';

abstract class ISaveCompletelyWordRepository {
  Future<Either<FailureDictionary, bool>> saveCompletelyWord(
      CompletelyWord wordCompleted);
}