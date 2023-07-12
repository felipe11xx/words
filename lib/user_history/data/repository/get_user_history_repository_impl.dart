import 'package:dartz/dartz.dart';
import 'package:words/user_history/data/datasource/get_user_history_datasource.dart';
import 'package:words/user_history/data/model/user_history.dart';
import 'package:words/user_history/domain/error/failure_user_history.dart';
import 'package:words/user_history/domain/repository/get_user_history_internal_repository.dart';

import '../../../shared/resources/strings.dart';

class GetUserHistoryInternalImpl implements IGetUserHistoryRepository {
  final IDoGetUserHistoryDataSource dataSource;

  GetUserHistoryInternalImpl(this.dataSource);

  @override
  Future<Either<FailureUserHistory, UserHistory?>> getUserHistory(String? userId) async {
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