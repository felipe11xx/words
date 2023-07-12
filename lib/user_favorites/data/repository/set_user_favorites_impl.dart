import 'package:dartz/dartz.dart';
import '../../../shared/resources/strings.dart';
import '../../domain/error/failure_user_favorites.dart';
import '../../domain/repository/set_user_favorites.dart';
import '../datasource/set_user_favourites_datasource.dart';

class SetUserFavoritesInternalImpl implements ISetUserFavoritesRepository {
  final IDoSetUserFavoritesDatasource dataSource;

  SetUserFavoritesInternalImpl(this.dataSource);

  @override
  Future<Either<FailureUserFavorites, bool>> setUserFavorites(String userId, String? word) async {
    try{
      final result = await dataSource.setUserFavorites(userId, word);
      return Right(result);
    } on UserFavoritesDataSourceError catch (e){
      return Left(e);
    } catch (e){
      return Left(UserFavoritesDataSourceError(message:Strings.genericError));
    }
  }
}