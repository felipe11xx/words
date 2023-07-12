
import 'package:dartz/dartz.dart';
import '../error/failure_user_favorites.dart';
import '../repository/set_user_favorites.dart';

abstract class IDoSetUserFavoritesUseCase {
  Future<Either<FailureUserFavorites, bool>> call(String userId, String? word);
}

class DoSetUserFavoritesUseCase implements IDoSetUserFavoritesUseCase {

  final ISetUserFavoritesRepository _setUserFavoritesRepository;

  DoSetUserFavoritesUseCase( this._setUserFavoritesRepository, );

  @override
  Future<Either<FailureUserFavorites, bool>> call(String userId, String? word) async{
    return await _setUserFavoritesRepository.setUserFavorites(userId,word);
  }
}