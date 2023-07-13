import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:words/user_favorites/data/model/user_favorites.dart';
import 'package:words/user_favorites/data/repository/get_favorites_repository_impl.dart';
import 'package:words/user_favorites/domain/error/failure_user_favorites.dart';
import 'package:words/user_favorites/data/datasource/get_favorites_datasource.dart';

class DoGetUserFavoritesDataSourceMock extends Mock implements IDoGetUserFavoritesDataSource {}

void main() {
  late GetUserFavoritesInternalImpl repository;
  late IDoGetUserFavoritesDataSource dataSourceMock;
  late UserFavorites userFavorites;
  late String userId;
  setUp(() {
    dataSourceMock = DoGetUserFavoritesDataSourceMock();
    repository = GetUserFavoritesInternalImpl(dataSourceMock);
    userId = 'id';
    userFavorites = UserFavorites(userId: userId,wordsFavorites: ['word']);
  });

  group('GetUserFavoritesInternalImpl', () {

    test('should return user favorites when the data source returns a result', () async {
      when(() => dataSourceMock.doGetUserFavorites(userId)).thenAnswer((_) async => userFavorites);

      final result = await repository.getUserFavorites(userId);

      expect(result, equals(Right(userFavorites)));
      verify(() => dataSourceMock.doGetUserFavorites(userId)).called(1);
    });

    test('should return UserFavoritesDataSourceError when the data source throws a UserFavoritesDataSourceError', () async {
      final error = UserFavoritesDataSourceError(message: 'Test Error');
      when(() => dataSourceMock.doGetUserFavorites(userId)).thenThrow(error);

      final result = await repository.getUserFavorites(userId);

      expect(result, equals(Left(error)));
      verify(() => dataSourceMock.doGetUserFavorites(userId)).called(1);
    });

    test('should return UserFavoritesDataSourceError with generic error message when an unknown error occurs', () async {
      final failure = UserFavoritesDataSourceError(message: 'any_error');


      when(() => dataSourceMock.doGetUserFavorites(userId)).thenThrow(failure);

      final result = await repository.getUserFavorites(userId);

      expect(result.fold((failure) => failure, (userFavorites) => userFavorites), failure);

      verify(() => dataSourceMock.doGetUserFavorites(userId)).called(1);
    });
  });
}
