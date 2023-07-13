import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:words/user_favorites/data/datasource/set_user_favourites_datasource.dart';
import 'package:words/user_favorites/data/repository/set_user_favorites_impl.dart';
import 'package:words/user_favorites/domain/error/failure_user_favorites.dart';

class DoSetUserFavoritesDataSourceMock extends Mock implements IDoSetUserFavoritesDatasource {}

void main() {
  late SetUserFavoritesInternalImpl repository;
  late IDoSetUserFavoritesDatasource dataSourceMock;
  late bool expectResult ;
  setUp(() {
    dataSourceMock = DoSetUserFavoritesDataSourceMock();
    repository = SetUserFavoritesInternalImpl(dataSourceMock);
    expectResult = true;
  });

  group('SetUserFavoritesInternalImpl', () {
    const userId = 'user123';
    const word = 'example';

    test('should return true when the data source successfully sets user favorites', () async {
      when(() => dataSourceMock.setUserFavorites(userId, word)).thenAnswer((_) async => true);

      final result = await repository.setUserFavorites(userId, word);

      expect(result, equals(Right(expectResult)));
      verify(() => dataSourceMock.setUserFavorites(userId, word)).called(1);
    });

    test('should return UserFavoritesDataSourceError when the data source throws a UserFavoritesDataSourceError', () async {
      final error = UserFavoritesDataSourceError(message: 'Test Error');
      when(() => dataSourceMock.setUserFavorites(userId, word)).thenThrow(error);

      final result = await repository.setUserFavorites(userId, word);

      expect(result, equals(Left(error)));
      verify(() => dataSourceMock.setUserFavorites(userId, word)).called(1);
    });

    test('should return UserFavoritesDataSourceError with generic error message when an unknown error occurs', () async {

      final failure = UserFavoritesDataSourceError(message: 'any_error');

      when(() => dataSourceMock.setUserFavorites(userId, word)).thenThrow(failure);

      final result = await repository.setUserFavorites(userId, word);

      expect(result.fold((failure) => failure, (userFavorites) => userFavorites), failure);

      verify(() => dataSourceMock.setUserFavorites(userId, word)).called(1);
    });
  });
}
