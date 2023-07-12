import 'package:dartz/dartz.dart';
import 'package:words/all_words/data/model/user_history.dart';
import '../repository/get_user_history_internal_repository.dart';
import 'package:words/all_words/domain/error/failure_all_words.dart';

abstract class IDoGetUserHistoryUseCase {
  Future<Either<FailureAllWords, UserHistory?>> call(String userId);
}

class DoGetUserHistoryUseCase implements IDoGetUserHistoryUseCase {

  final IGetUserHistoryRepository _getUserHistoryRepository;


  DoGetUserHistoryUseCase( this._getUserHistoryRepository, );

  @override
  Future<Either<FailureAllWords, UserHistory?>> call(String userId) async{
   return await _getUserHistoryRepository.getUserHistory(userId);
  }
}