import 'package:dartz/dartz.dart';
import '../../../shared/resources/strings.dart';
import '../datasource/get_favorites_datasource.dart';
import '../../domain/repository/get_user_favorites_repository.dart';
import 'package:words/user_favorites/data/model/user_favorites.dart';
import 'package:words/user_favorites/domain/error/failure_user_favorites.dart';

class GetUserFavoritesInternalImpl implements IGetUserFavoritesRepository {
  final IDoGetUserFavoritesDataSource dataSource;

  GetUserFavoritesInternalImpl(this.dataSource);

  @override
  Future<Either<FailureUserFavorites, UserFavorites?>> getUserFavorites(String? userId) async {
    try{
      final result = await dataSource.doGetUserFavorites(userId);
      return Right(result);
    } on UserFavoritesDataSourceError catch (e){
      return Left(e);
    } catch (e){
      return Left(UserFavoritesDataSourceError(message:Strings.genericError));
    }
  }


}