abstract class FailureAllWords implements Exception{}

class UserHistoryDataSourceError implements FailureAllWords {

  final String? message;

  UserHistoryDataSourceError({this.message,});

}

class UserFavoritesDataSourceError implements FailureAllWords {
  final String? message;

  UserFavoritesDataSourceError({
    this.message,

  });
}