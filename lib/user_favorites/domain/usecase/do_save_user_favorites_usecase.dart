
import 'package:dartz/dartz.dart';
import '../error/failure_user_favorites.dart';
import '../repository/save_user_favorites.dart';

abstract class IDoSaveUserFavoritesUseCase {
  Future<Either<FailureUserFavorites, bool>> call(String userId, String? word);
}

class DoSaveUserFavoritesUseCase implements IDoSaveUserFavoritesUseCase {

  final ISaveUserFavoritesRepository _saveUserFavoritesRepository;

  DoSaveUserFavoritesUseCase( this._saveUserFavoritesRepository, );

  @override
  Future<Either<FailureUserFavorites, bool>> call(String userId, String? word) async{
    return await _saveUserFavoritesRepository.saveUserFavorites(userId,word);
  }
}