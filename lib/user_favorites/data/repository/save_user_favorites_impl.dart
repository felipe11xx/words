import 'package:dartz/dartz.dart';
import '../../../shared/resources/strings.dart';
import '../../domain/error/failure_user_favorites.dart';
import '../../domain/repository/save_user_favorites.dart';
import '../datasource/save_user_favourites_datasource.dart';

class SaveUserFavoritesInternalImpl implements ISaveUserFavoritesRepository {
  final IDoSaveUserFavoritesDatasource dataSource;

  SaveUserFavoritesInternalImpl(this.dataSource);

  @override
  Future<Either<FailureUserFavorites, bool>> saveUserFavorites(String userId, String? word) async {
    try{
      final result = await dataSource.saveUserFavorites(userId, word);
      return Right(result);
    } on UserFavoritesDataSourceError catch (e){
      return Left(e);
    } catch (e){
      return Left(UserFavoritesDataSourceError(message:Strings.genericError));
    }
  }
}