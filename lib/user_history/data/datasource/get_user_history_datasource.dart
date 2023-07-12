
import 'package:words/user_history/data/model/user_history.dart';

abstract class IDoGetUserHistoryDataSource {
  Future<UserHistory?> doGetUseHistory(String? userId);
}