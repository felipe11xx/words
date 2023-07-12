import 'package:dartz/dartz.dart';

import '../error/failure_user_favorites.dart';

abstract class ISaveUserFavoritesRepository {
  Future<Either<FailureUserFavorites,bool>> saveUserFavorites(String userId, String? word);
}