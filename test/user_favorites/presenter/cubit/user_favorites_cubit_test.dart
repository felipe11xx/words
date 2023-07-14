import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:words/shared/services/auth_service.dart';
import 'package:words/user_favorites/domain/error/failure_user_favorites.dart';
import 'package:words/user_favorites/presenter/cubit/cubits.dart';
import 'package:words/user_favorites/data/model/user_favorites.dart';
import 'package:words/user_favorites/domain/usecase/do_get_user_favorites_usecase.dart';

class DoGetUserFavoritesUseCaseMock extends Mock implements DoGetUserFavoritesUseCase {}

class AuthServiceMock extends Mock implements AuthService {}

class UserMock extends Mock implements User{
  @override
  String get uid => '123';
}

void main() {
  late FavoritesCubit favoritesCubit;
  late DoGetUserFavoritesUseCase doGetUserFavoritesUseCaseMock;
  late AuthServiceMock authServiceMock;
  late UserFavorites userFavorites;
  setUp(() {
    doGetUserFavoritesUseCaseMock = DoGetUserFavoritesUseCaseMock();
    authServiceMock = AuthServiceMock();
    favoritesCubit = FavoritesCubit(doGetUserFavoritesUseCaseMock, authServiceMock);
    userFavorites = UserFavorites(userId: '123', wordsFavorites: ['word1','word2']);
  });

  group('FavoritesCubit', () {

    test('initial state should be FavoritesInitialState', () {
      expect(favoritesCubit.state, equals(FavoritesInitialState()));
    });

    blocTest<FavoritesCubit, FavoritesState>(
      'getWords should emit FavoritesLoadingState and FavoritesSuccessState on success',
      build: () {
        when(() => doGetUserFavoritesUseCaseMock.call(any()))
            .thenAnswer((_) async =>  Right(userFavorites));


        TestWidgetsFlutterBinding.ensureInitialized();
        return favoritesCubit;
      },
      act: (cubit) => cubit.getWords(),
      expect: () => [
        isA<FavoritesLoadingState>(),
        isA<FavoritesSuccessState>(),
      ],
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'getWords should emit FavoritesLoadingState and FavoritesEmptyState on success but words list is empty',
      build: () {
        final  userFavorites0 = UserFavorites(userId: '123', wordsFavorites: []) ;

        when(() => doGetUserFavoritesUseCaseMock.call(any()))
            .thenAnswer((_) async =>  Right(userFavorites0));


        TestWidgetsFlutterBinding.ensureInitialized();
        return favoritesCubit;
      },
      act: (cubit) => cubit.getWords(),
      expect: () => [
        isA<FavoritesLoadingState>(),
        isA<FavoritesEmptyState>(),
      ],
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'getWords should emit FavoritesErrorState on fails',
      build: () {

        when(() => doGetUserFavoritesUseCaseMock.call(any()))
            .thenAnswer((_) async =>  Left(UserFavoritesDataSourceError()));


        TestWidgetsFlutterBinding.ensureInitialized();
        return favoritesCubit;
      },
      act: (cubit) => cubit.getWords(),
      expect: () => [
        isA<FavoritesLoadingState>(),
        isA<FavoritesErrorState>(),
      ],
    );

    test('getUserId should return the correct user ID', () {

      when(() => authServiceMock.userAuth).thenReturn(UserMock());

      final result = favoritesCubit.getUserId();

      expect(result, equals('123'));
    });
  });
}
