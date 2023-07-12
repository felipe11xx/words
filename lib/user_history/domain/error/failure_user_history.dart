abstract class FailureUserHistory implements Exception{}

class UserHistoryDataSourceError implements FailureUserHistory {

  final String? message;

  UserHistoryDataSourceError({this.message,});

}

