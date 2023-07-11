import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import '../domain/error/failure_all_words.dart';
import '../data/datasource/get_user_history_datasource.dart';
import 'package:words/all_words/data/model/user_history.dart';

class DoGetUserHistoryInternalDatasource implements IDoGetUserHistoryDataSource{
  DoGetUserHistoryInternalDatasource();

  @override
  Future<UserHistory> doGetUseHistory(String? userId) async {
    try {
      final userHistoryBox = await Hive.openBox('userHistory');
      final userHistory = await userHistoryBox.get(userId);
      return userHistory;
    } catch (e) {
      debugPrint('err ${e.toString()}' );
      throw UserHistoryDataSourceError(message: e.toString(), );
    }
  }

}