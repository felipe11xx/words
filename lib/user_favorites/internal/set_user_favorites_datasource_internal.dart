import 'package:hive/hive.dart';
import '../data/model/user_favorites.dart';
import '../domain/error/failure_user_favorites.dart';
import '../data/datasource/set_user_favourites_datasource.dart';

class DoSetUserFavoritesDatasourceInternal implements IDoSetUserFavoritesDatasource{
  DoSetUserFavoritesDatasourceInternal();

  @override
  Future<bool> setUserFavorites(String userId, String? word) async{
    try {
      final userFavoritesBox = await Hive.openBox('userFavorites');

      final userFavorites = userFavoritesBox.get(userId) as UserFavorites?;
      if (userFavorites != null) {
        if (!userFavorites.wordsFavorites.contains(word)) {
          List<String> upUserFavorites = [
            ...userFavorites.wordsFavorites,
            word ?? ''
          ];
          userFavoritesBox.put(
              userId, UserFavorites(userId: userId, wordsFavorites: upUserFavorites));
        }else{
          userFavorites.wordsFavorites.remove(word);
          userFavoritesBox.put(
              userId, UserFavorites(userId: userId, wordsFavorites: userFavorites.wordsFavorites));
        }
      } else {
        userFavoritesBox.put(userId,
            UserFavorites(userId: userId, wordsFavorites: [word ?? '']));}

      return true;
    } catch (e) {
      throw UserFavoritesDataSourceError(
        message: e.toString(),
      );
    }
  }
}
