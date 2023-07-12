import 'package:dartz/dartz.dart';
import 'package:words/user_history/data/model/user_history.dart';
import 'package:words/user_history/domain/error/failure_user_history.dart';

abstract class IGetUserHistoryRepository {
  Future<Either<FailureUserHistory,UserHistory?>>getUserHistory(String? userId);
}