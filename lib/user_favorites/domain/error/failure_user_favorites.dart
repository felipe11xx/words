abstract class FailureUserFavorites implements Exception{}

class UserFavoritesDataSourceError implements FailureUserFavorites {

  final String? message;

  UserFavoritesDataSourceError({this.message,});

}

