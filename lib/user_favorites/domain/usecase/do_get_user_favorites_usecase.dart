
import 'package:dartz/dartz.dart';
import 'package:words/user_favorites/data/model/user_favorites.dart';
import 'package:words/user_favorites/domain/error/failure_user_favorites.dart';

import '../repository/get_user_favorites_repository.dart';

abstract class IDoGetUserFavoritesUseCase {
  Future<Either<FailureUserFavorites, UserFavorites?>> call(String userId);
}

class DoGetUserHistoryUseCase implements IDoGetUserFavoritesUseCase {

  final IGetUserFavoritesRepository _getUserFavoritesRepository;


  DoGetUserHistoryUseCase( this._getUserFavoritesRepository, );

  @override
  Future<Either<FailureUserFavorites, UserFavorites?>> call(String userId) async{
    return await _getUserFavoritesRepository.getUserFavorites(userId);
  }
}