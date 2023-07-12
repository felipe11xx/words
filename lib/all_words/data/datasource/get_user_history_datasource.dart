
import 'package:words/all_words/data/model/user_history.dart';

abstract class IDoGetUserHistoryDataSource {
  Future<UserHistory?> doGetUseHistory(String? userId);
}