import 'package:dartz/dartz.dart';
import '../error/failure_user_history.dart';

abstract class ISaveUserHistoryRepository {
  Future<Either<FailureUserHistory,bool>> saveUserHistory(String userId, String? word);
}