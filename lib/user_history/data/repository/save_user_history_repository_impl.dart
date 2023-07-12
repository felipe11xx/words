import 'package:dartz/dartz.dart';
import '../../../shared/resources/strings.dart';
import '../../domain/error/failure_user_history.dart';
import '../datasource/save_user_history_datasource.dart';
import '../../domain/repository/save_user_history_repository.dart';

class SaveUserHistoryInternalImpl implements ISaveUserHistoryRepository {
  final IDoSaveUserHistoryDatasource dataSource;

  SaveUserHistoryInternalImpl(this.dataSource);

  @override
  Future<Either<FailureUserHistory, bool>> saveUserHistory(String userId, String? word) async {
    try{
      final result = await dataSource.saveUserHistory(userId, word);
    return Right(result);
    } on UserHistoryDataSourceError catch (e){
    return Left(e);
    } catch (e){
    return Left(UserHistoryDataSourceError(message:Strings.genericError));
    }
  }
}