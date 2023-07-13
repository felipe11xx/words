import '../data/model/user_favorites.dart';
import '../domain/error/failure_user_favorites.dart';
import 'package:words/shared/services/hive_service.dart';
import '../data/datasource/set_user_favourites_datasource.dart';

class DoSetUserFavoritesDatasourceInternal
    implements IDoSetUserFavoritesDatasource {
  DoSetUserFavoritesDatasourceInternal(this.hive);

  final HiveService hive;

  @override
  Future<bool> setUserFavorites(String userId, String? word) async {
    try {
      final userFavoritesBox = await hive.openBox('userFavorites');

      var userFavorites = userFavoritesBox.get(userId) as UserFavorites?;
      if (userFavorites != null) {
        if (!userFavorites.wordsFavorites.contains(word)) {
          List<String> upUserFavorites = [
            ...userFavorites.wordsFavorites,
            word ?? ''
          ];
          userFavorites.wordsFavorites = upUserFavorites;
          userFavoritesBox.put(userId, userFavorites);
        } else {
          userFavorites.wordsFavorites.remove(word);
          userFavoritesBox.put(userId, userFavorites);
        }
      } else {
        userFavorites =
            UserFavorites(userId: userId, wordsFavorites: [word ?? '']);
        userFavoritesBox.put(userId, userFavorites);
      }

      return true;
    } catch (e) {
      throw UserFavoritesDataSourceError(
        message: e.toString(),
      );
    }
  }
}
