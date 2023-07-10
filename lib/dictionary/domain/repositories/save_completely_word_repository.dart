import 'package:dartz/dartz.dart';
import '../error/failure_word.dart';
import 'package:words/dictionary/data/model/models.dart';

abstract class ISaveCompletelyWordRepository {
  Future<Either<FailureWord, bool>> saveCompletelyWord(
      CompletelyWord wordCompleted);
}