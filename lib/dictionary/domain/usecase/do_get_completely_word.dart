import 'package:dartz/dartz.dart';
import 'package:words/dictionary/data/model/models.dart';
import 'package:words/dictionary/domain/error/failure_word.dart';
import 'package:words/dictionary/domain/repositories/get_completely_word_repository.dart';

import '../repositories/get_completely_word_internal_repository.dart';

abstract class IDoGetCompletelyWordUseCase {
  Future<Either<FailureWord, CompletelyWord>> call(String? word);
}

class DoGetCompletelyWordUseCase implements IDoGetCompletelyWordUseCase {

  final IGetCompletelyWordRepository _getCompletelyWordRepository;
  final IGetCompletelyWordInternalRepository _getCompletelyWordInternalRepository;

  DoGetCompletelyWordUseCase( this._getCompletelyWordRepository, this._getCompletelyWordInternalRepository);

  @override
  Future<Either<FailureWord, CompletelyWord>> call(String? word) async{

    final result = await _getCompletelyWordInternalRepository.getCompletelyWordInternal(word);
    return result.isRight() ? result :await _getCompletelyWordRepository.getCompletelyWord(word);
  }
}