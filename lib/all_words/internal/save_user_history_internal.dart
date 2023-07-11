
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:words/all_words/data/datasource/save_user_history_datasource.dart';

import '../data/model/user_history.dart';
import '../domain/error/failure_all_words.dart';

class DoSaveUserHistoryInternalDatasource implements IDoSaveUserHistoryDatasource{
  DoSaveUserHistoryInternalDatasource();

  @override
  Future<bool> saveUserHistory(String userId, String? word) async{
      try {
        final userHistoricBox = await Hive.openBox('historicUser');

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

          debugPrint('deu bom atualizar ${userHistory.wordHistory[0]}');
          debugPrint('deu bom atualizar ${userHistory.wordHistory.length}');
        } else {
          userHistoricBox.put(userId,
              UserHistory(userId: userId, wordHistory: [word ?? '']));
          debugPrint('deu bom salvar');
        }

        return true;
      } catch (e) {
        debugPrint('err ${e.toString()}');
        throw UserHistoryDataSourceError(
          message: e.toString(),
        );
      }
  }


}
