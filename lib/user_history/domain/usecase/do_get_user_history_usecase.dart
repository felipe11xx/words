import 'package:dartz/dartz.dart';
import 'package:words/user_history/data/model/user_history.dart';
import '../repository/get_user_history_internal_repository.dart';
import 'package:words/user_history/domain/error/failure_user_history.dart';

abstract class IDoGetUserHistoryUseCase {
  Future<Either<FailureUserHistory, UserHistory?>> call(String userId);
}

class DoGetUserHistoryUseCase implements IDoGetUserHistoryUseCase {

  final IGetUserHistoryRepository _getUserHistoryRepository;


  DoGetUserHistoryUseCase( this._getUserHistoryRepository, );

  @override
  Future<Either<FailureUserHistory, UserHistory?>> call(String userId) async{
   return await _getUserHistoryRepository.getUserHistory(userId);
  }
}