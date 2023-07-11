import 'package:dartz/dartz.dart';
import 'package:words/dictionary/data/model/models.dart';
import 'package:words/dictionary/domain/error/failure_dictionary.dart';

abstract class IGetCompletelyWordInternalRepository {
  Future<Either<FailureDictionary,CompletelyWord>>getCompletelyWordInternal(String? word);
}