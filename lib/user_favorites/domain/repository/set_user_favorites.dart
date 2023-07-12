import 'package:dartz/dartz.dart';

import '../error/failure_user_favorites.dart';

abstract class ISetUserFavoritesRepository {
  Future<Either<FailureUserFavorites,bool>> setUserFavorites(String userId, String? word);
}