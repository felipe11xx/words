import 'package:flutter/material.dart';
import '../../shared/services/hive_service.dart';
import '../domain/error/failure_user_history.dart';
import '../data/datasource/get_user_history_datasource.dart';
import 'package:words/user_history/data/model/user_history.dart';

class DoGetUserHistoryDatasourceInternal implements IDoGetUserHistoryDataSource{
  DoGetUserHistoryDatasourceInternal(this.hive);

  final HiveService hive;


  @override
  Future<UserHistory?> doGetUserHistory(String? userId) async {
    try {
      final userHistoryBox = await hive.openBox('userHistory');
      final userHistory = userHistoryBox.get(userId) as UserHistory?;
      return userHistory ;
    } catch (e) {
      debugPrint('err ${e.toString()}' );
      throw UserHistoryDataSourceError(message: e.toString(), );
    }
  }

}