import 'package:dartz/dartz.dart';
import 'package:words/dictionary/data/model/models.dart';
import 'package:words/dictionary/domain/error/failure_word.dart';
import 'package:words/dictionary/domain/repositories/save_completely_word_repository.dart';

abstract class IDoSaveCompletelyWordUseCase {
  Future<Either<FailureWord, bool>> call(CompletelyWord wordCompleted);
}

class DoSaveCompletelyWordUseCase implements IDoSaveCompletelyWordUseCase {
  final ISaveCompletelyWordRepository _saveCompletelyWordRepository;

  DoSaveCompletelyWordUseCase(this._saveCompletelyWordRepository);

  @override
  Future<Either<FailureWord, bool>> call(CompletelyWord wordCompleted) async {
    return await _saveCompletelyWordRepository.saveCompletelyWord(wordCompleted);
  }
}
