import 'package:dartz/dartz.dart';
import 'package:words/dicionary/data/model/models.dart';
import 'package:words/dicionary/domain/error/failure_word.dart';
import 'package:words/dicionary/domain/repositories/get_completely_word_repository.dart';

abstract class IDoGetCompletelyWordUseCase {
  Future<Either<FailureWord, WordCompleted>> call(String? word);
}

class DoGetCompletelyWord implements IDoGetCompletelyWordUseCase {

  final IGetCompletelyWordRepository _getCompletelyWordRepository;

  DoGetCompletelyWord({required IGetCompletelyWordRepository iGetCompletelyWordRepository}):_getCompletelyWordRepository = iGetCompletelyWordRepository;

  @override
  Future<Either<FailureWord, WordCompleted>> call(String? word) {
    return _getCompletelyWordRepository.getCompletelyWord(word);
  }
}