import 'package:dartz/dartz.dart';
import 'package:words/dictionary/data/model/models.dart';
import 'package:words/dictionary/domain/error/failure_word.dart';

abstract class IGetCompletelyWordInternalRepository {
  Future<Either<FailureWord,CompletelyWord>>getCompletelyWordInternal(String? word);
}