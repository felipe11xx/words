import 'cubits.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/services/auth_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../domain/error/failure_user_favorites.dart';
import '../../domain/usecase/do_get_user_favorites_usecase.dart';

final $FavoritesCubit = Bind.singleton((i) => FavoritesCubit(i(), i()));

class FavoritesCubit extends Cubit<FavoritesState> {
  final DoGetUserFavoritesUseCase _doGetUserFavoritesUseCase;
  final AuthService _authServices;

  FavoritesCubit(this._doGetUserFavoritesUseCase, this._authServices)
      : super(FavoritesInitialState());

  getWords() async {
    emit(FavoritesLoadingState(true));

    var result = await _doGetUserFavoritesUseCase.call(getUserId());

    result.fold((l) =>
        emit(FavoritesErrorState(l as UserFavoritesDataSourceError)),
            (r) {
          if(r == null || r.wordsFavorites.isEmpty){
            emit(FavoritesEmptyState(true));
          }else{
            emit(FavoritesSuccessState(r.wordsFavorites ));
          }
        }
    );
  }

  String getUserId() {
    return _authServices.userAuth?.uid ?? '';
  }

}