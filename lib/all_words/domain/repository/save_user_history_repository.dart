import 'package:dartz/dartz.dart';
import '../error/failure_all_words.dart';

abstract class ISaveUserHistoryRepository {
  Future<Either<FailureAllWords,bool>> saveUserHistory(String userId, String? word);
}