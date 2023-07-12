abstract class IDoSaveUserHistoryDatasource {
  Future<bool> saveUserHistory(String userId,String? word);
}