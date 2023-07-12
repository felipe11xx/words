
import 'package:words/user_favorites/data/model/user_favorites.dart';

abstract class IDoGetUserFavoritesDataSource {
  Future<UserFavorites?> doGetUserFavorites(String? userId);
}