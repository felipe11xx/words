import 'package:dartz/dartz.dart';
import '../error/failure_all_words.dart';
import '../repository/save_user_history_repository.dart';

abstract class IDoSaveUserHistoryUseCase {
  Future<Either<FailureAllWords, bool>> call(String userId, String? word);
}

class DoSaveUserHistoryUseCase implements IDoSaveUserHistoryUseCase {

  final ISaveUserHistoryRepository _saveUserHistoryRepository;

  DoSaveUserHistoryUseCase( this._saveUserHistoryRepository, );

  @override
  Future<Either<FailureAllWords, bool>> call(String userId, String? word) async{
    return await _saveUserHistoryRepository.saveUserHistory(userId,word);
  }
}