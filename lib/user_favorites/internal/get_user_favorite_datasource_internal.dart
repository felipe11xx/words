import 'package:hive/hive.dart';
import '../domain/error/failure_user_favorites.dart';
import '../data/datasource/get_favorites_datasource.dart';
import 'package:words/user_favorites/data/model/user_favorites.dart';

class DoGetUserFavoritesDatasourceInternal implements IDoGetUserFavoritesDataSource{
  DoGetUserFavoritesDatasourceInternal();

  @override
  Future<UserFavorites?> doGetUserFavorites(String? userId) async {
    try {
      final userFavoritesBox = await Hive.openBox('userFavorites');
      final userFavorites = userFavoritesBox.get(userId) as UserFavorites?;
      return userFavorites ;
    } catch (e) {
      throw UserFavoritesDataSourceError(message: e.toString(), );
    }
  }

}