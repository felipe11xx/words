import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:words/user_favorites/data/model/user_favorites.dart';
import 'package:words/user_favorites/domain/error/failure_user_favorites.dart';
import 'package:words/user_favorites/data/repository/set_user_favorites_impl.dart';
import 'package:words/user_favorites/data/datasource/set_user_favourites_datasource.dart';

class IDoSetUserFavoritesDatasourceMock extends Mock
    implements IDoSetUserFavoritesDatasource {}

void main() {
  late SetUserFavoritesInternalImpl setUserFavoritesInternalImpl;
  late IDoSetUserFavoritesDatasource setUserFavoritesRepositoryMock;
  late UserFavorites userFavorites;
  late String userId;
  late bool expectedResult;


  setUp(() {
    setUserFavoritesRepositoryMock = IDoSetUserFavoritesDatasourceMock();
    setUserFavoritesInternalImpl = SetUserFavoritesInternalImpl(setUserFavoritesRepositoryMock);
    userId = 'id';
    userFavorites = UserFavorites(userId: userId,wordsFavorites: ['word']);
    expectedResult = true;
  });

  test('Should save UserFavorites()', () async {
    when(()=>setUserFavoritesRepositoryMock.setUserFavorites(userFavorites.userId,'word'))
        .thenAnswer((_) async => expectedResult);

    final result =
    await setUserFavoritesInternalImpl.setUserFavorites(userFavorites.userId,'word');

    expect(result, Right(expectedResult));

    expect(
        result.fold((failure) => failure, (userFavorites) => userFavorites),
        isA<bool>());
  });
  

  test('Should return UserFavoritesDataSourceError() when call to dataSource throw a exception ', () async {
      final expectedError = UserFavoritesDataSourceError(message: 'Erro');

      when(()=>setUserFavoritesRepositoryMock.setUserFavorites(userFavorites.userId,'word')).thenThrow(expectedError);
      final result =
      await setUserFavoritesInternalImpl.setUserFavorites(userFavorites.userId,'word');

      expect(
          result.fold((failure) => failure, (userFavorites) => userFavorites),
          isA<UserFavoritesDataSourceError>());
  });

}
