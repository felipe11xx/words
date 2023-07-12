import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import '../domain/error/failure_user_history.dart';
import '../data/datasource/get_user_history_datasource.dart';
import 'package:words/user_history/data/model/user_history.dart';

class DoGetUserHistoryDatasourceInternal implements IDoGetUserHistoryDataSource{
  DoGetUserHistoryDatasourceInternal();

  @override
  Future<UserHistory?> doGetUserHistory(String? userId) async {
    try {
      final userHistoryBox = await Hive.openBox('userHistory');
      final userHistory = userHistoryBox.get(userId) as UserHistory?;
      return userHistory ;
    } catch (e) {
      debugPrint('err ${e.toString()}' );
      throw UserHistoryDataSourceError(message: e.toString(), );
    }
  }

}