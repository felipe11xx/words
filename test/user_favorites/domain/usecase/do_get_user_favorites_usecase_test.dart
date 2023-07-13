import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:words/user_favorites/data/model/user_favorites.dart';
import 'package:words/user_favorites/domain/error/failure_user_favorites.dart';
import 'package:words/user_favorites/domain/repository/get_user_favorites_repository.dart';
import 'package:words/user_favorites/domain/usecase/do_get_user_favorites_usecase.dart';

class GetUserFavoritesRepositoryMock extends Mock implements IGetUserFavoritesRepository {}

void main() {
  late DoGetUserFavoritesUseCase useCase;
  late IGetUserFavoritesRepository repositoryMock;
  late UserFavorites userFavorites;
  setUp(() {
    repositoryMock = GetUserFavoritesRepositoryMock();
    useCase = DoGetUserFavoritesUseCase(repositoryMock);
    userFavorites = UserFavorites(userId: "123", wordsFavorites: ['word']);
  });

  group('DoGetUserFavoritesUseCase', () {

    test('should return user favorites when repository returns a result', () async {
      when(() => repositoryMock.getUserFavorites(userFavorites.userId)).thenAnswer((_) async => Right(userFavorites));

      final result = await useCase.call(userFavorites.userId);

      expect(result, equals(Right(userFavorites)));
      verify(() => repositoryMock.getUserFavorites(userFavorites.userId)).called(1);
    });

    test('should return FailureUserFavorites when repository returns a failure', () async {
      final failure = UserFavoritesDataSourceError(message: 'Test Failure');
      when(() => repositoryMock.getUserFavorites(userFavorites.userId)).thenAnswer((_) async => Left(failure));

      final result = await useCase.call(userFavorites.userId);

      expect(result, equals(Left(failure)));
      verify(() => repositoryMock.getUserFavorites(userFavorites.userId)).called(1);
    });
  });
}
