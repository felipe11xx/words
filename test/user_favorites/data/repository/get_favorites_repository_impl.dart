import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:words/user_favorites/data/datasource/get_favorites_datasource.dart';
import 'package:words/user_favorites/data/model/user_favorites.dart';
import 'package:words/user_favorites/data/repository/get_favorites_repository_impl.dart';
import 'package:words/user_favorites/domain/error/failure_user_favorites.dart';

class IDoGetUserFavoritesDataSourceMock extends Mock
    implements IDoGetUserFavoritesDataSource {}


main() {
  late IDoGetUserFavoritesDataSource doGetUserFavoritesDataSource;
  late GetUserFavoritesInternalImpl getUserFavoritesInternalImpl;
  late UserFavorites userFavorites;
  late String userId;

  setUpAll(() {
    doGetUserFavoritesDataSource = IDoGetUserFavoritesDataSourceMock();
    getUserFavoritesInternalImpl =
        GetUserFavoritesInternalImpl(doGetUserFavoritesDataSource);
    userId = 'id';
    userFavorites = UserFavorites(userId: userId,wordsFavorites: ['word']);

  });

  test("Should return UserFavorites", () async {
    when(() => doGetUserFavoritesDataSource.doGetUserFavorites(userId)).thenAnswer((_) async => userFavorites);

    final result =
    await getUserFavoritesInternalImpl.getUserFavorites(userId);

    expect(
        result.fold((failure) => failure, (userFavorites) => userFavorites),
        isA<UserFavorites>());
  });



  test("Should return UserFavoritesDataSourceError() when call to dataSource throw a exception", () async {
    when(() => doGetUserFavoritesDataSource.doGetUserFavorites(userId)).thenThrow(Exception(any));

    final result =
    await getUserFavoritesInternalImpl.getUserFavorites(userId);

    expect(
        result.fold((failure) => failure, (userFavorites) => userFavorites),
        isA<UserFavoritesDataSourceError>());
  });

}
