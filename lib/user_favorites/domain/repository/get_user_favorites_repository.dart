import 'package:dartz/dartz.dart';
import 'package:words/user_favorites/data/model/user_favorites.dart';
import 'package:words/user_favorites/domain/error/failure_user_favorites.dart';

abstract class IGetUserFavoritesRepository {
  Future<Either<FailureUserFavorites,UserFavorites?>>getUserFavorites(String? userId);
}