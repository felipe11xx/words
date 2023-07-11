import 'package:dartz/dartz.dart';
import 'package:words/dictionary/data/model/models.dart';
import 'package:words/dictionary/domain/error/failure_dictionary.dart';

abstract class IGetCompletelyWordRepository {
  Future<Either<FailureDictionary,CompletelyWord>>getCompletelyWord(String? word);
}