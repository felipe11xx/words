import 'package:dartz/dartz.dart';
import 'package:words/all_words/data/datasource/get_user_history_datasource.dart';
import 'package:words/all_words/data/model/user_history.dart';
import 'package:words/all_words/domain/error/failure_all_words.dart';
import 'package:words/all_words/domain/repository/get_user_history_internal_repository.dart';

import '../../../shared/resources/strings.dart';

class GetUserHistoryInternalImpl implements IGetUserHistoryRepository {
  final IDoGetUserHistoryDataSource dataSource;

  GetUserHistoryInternalImpl(this.dataSource);

  @override
  Future<Either<FailureAllWords, UserHistory>> getUserHistory(String? userId) async {
    try{
      final result = await dataSource.doGetUseHistory(userId);
      return Right(result);
    } on UserHistoryDataSourceError catch (e){
      return Left(e);
    } catch (e){
      return Left(UserHistoryDataSourceError(message:Strings.genericError));
    }
  }


}