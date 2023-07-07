import 'package:dartz/dartz.dart';
import 'package:words/dicionary/data/model/models.dart';
import 'package:words/dicionary/domain/error/failure_word.dart';

abstract class IGetCompletelyWordRepository {
  Future<Either<FailureWord,WordCompleted>>getCompletelyWord(String? word);
}