import 'package:dartz/dartz.dart';
import 'package:words/all_words/data/model/user_history.dart';
import 'package:words/all_words/domain/error/failure_all_words.dart';

abstract class IGetUserHistoryRepository {
  Future<Either<FailureAllWords,UserHistory?>>getUserHistory(String? userId);
}