import 'package:equatable/equatable.dart';

import '../../domain/error/failure_user_favorites.dart';

abstract class FavoritesState extends Equatable{}

class FavoritesInitialState extends FavoritesState {

  @override
  List<Object?> get props => [];
}

class FavoritesLoadingState extends FavoritesState {
  final bool prop;

  FavoritesLoadingState(this.prop);

  @override
  List<Object?> get props => [prop];
}

class FavoritesSuccessState extends FavoritesState {
  final List<String?> list;

  FavoritesSuccessState(this.list);

  @override
  List<Object?> get props => [list];
}


class FavoritesErrorState extends FavoritesState {
  final UserFavoritesDataSourceError exception;

  FavoritesErrorState(this.exception);

  @override
  List<Object?> get props => [exception];
}

class FavoritesEmptyState extends FavoritesState {
  final bool prop;

  FavoritesEmptyState(this.prop);

  @override
  List<Object?> get props => [prop];
}