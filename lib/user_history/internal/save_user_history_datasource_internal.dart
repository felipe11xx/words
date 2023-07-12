import 'package:hive/hive.dart';
import '../data/model/user_history.dart';
import '../domain/error/failure_user_history.dart';
import 'package:words/user_history/data/datasource/save_user_history_datasource.dart';

class DoSaveUserHistoryDatasourceInternal implements IDoSaveUserHistoryDatasource{
  DoSaveUserHistoryDatasourceInternal();

  @override
  Future<bool> saveUserHistory(String userId, String? word) async{
      try {
        final userHistoricBox = await Hive.openBox('userHistory');

        final userHistory = userHistoricBox.get(userId) as UserHistory?;
        if (userHistory != null) {
          if (!userHistory.wordHistory.contains(word)) {
            List<String> upUserHistory = [
              ...userHistory.wordHistory,
              word ?? ''
            ];
            userHistoricBox.put(
                userId, UserHistory(userId: userId, wordHistory: upUserHistory));
          }
        } else {
          userHistoricBox.put(userId,
              UserHistory(userId: userId, wordHistory: [word ?? '']));}

        return true;
      } catch (e) {
        throw UserHistoryDataSourceError(
          message: e.toString(),
        );
      }
  }


}
