import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:words/dictionary/data/model/models.dart';
import 'package:words/dictionary/domain/error/failure_dictionary.dart';
import 'package:words/dictionary/domain/usecase/do_get_completely_word_usecase.dart';
import 'package:words/dictionary/domain/usecase/do_save_completely_word_usecase.dart';
import 'package:words/dictionary/presenter/cubit/cubits.dart';
import 'package:words/user_favorites/data/model/user_favorites.dart';
import 'package:words/user_favorites/domain/usecase/do_get_user_favorites_usecase.dart';
import 'package:words/user_favorites/domain/usecase/do_set_user_favorites_usecase.dart';
import 'package:words/shared/services/auth_service.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:words/shared/services/tts_service.dart';

class DoGetCompletelyWordUseCaseMock extends Mock
    implements DoGetCompletelyWordUseCase {}

class DoSaveCompletelyWordUseCaseMock extends Mock
    implements DoSaveCompletelyWordUseCase {}

class DoGetUserFavoritesUseCaseMock extends Mock
    implements DoGetUserFavoritesUseCase {}

class DoSetUserFavoritesUseCaseMock extends Mock
    implements DoSetUserFavoritesUseCase {}

class AuthServiceMock extends Mock implements AuthService {}

class AppTTSMock extends Mock implements AppTTS {}

void main() {
  group('CompletelyWordCubit', () {
    late CompletelyWordCubit completelyWordCubit;
    late DoGetCompletelyWordUseCaseMock getCompletelyWordUseCaseMock;
    late DoSaveCompletelyWordUseCaseMock saveCompletelyWordUseCaseMock;
    late AppTTSMock appTTSMock;
    late DoSetUserFavoritesUseCaseMock setUserFavoritesUseCaseMock;
    late DoGetUserFavoritesUseCaseMock getUserFavoritesUseCaseMock;
    late AuthServiceMock authServiceMock;
    late UserFavorites userFavorites;
    late String userId;
    const word = 'test';

    final completelyWord = CompletelyWord(results: [
      Results(definition: 'Definition 1'),
      Results(definition: 'Definition 2'),
    ]);

    final completelyWordDataSourceError =
        CompletelyWordDataSourceError(message: 'Failed to get completely word');

    setUp(() {
      getCompletelyWordUseCaseMock = DoGetCompletelyWordUseCaseMock();
      saveCompletelyWordUseCaseMock = DoSaveCompletelyWordUseCaseMock();
      appTTSMock = AppTTSMock();
      setUserFavoritesUseCaseMock = DoSetUserFavoritesUseCaseMock();
      getUserFavoritesUseCaseMock = DoGetUserFavoritesUseCaseMock();
      authServiceMock = AuthServiceMock();
      userId = '2';
      userFavorites = UserFavorites(userId: userId, wordsFavorites: []);
      completelyWordCubit = CompletelyWordCubit(
        getCompletelyWordUseCaseMock,
        saveCompletelyWordUseCaseMock,
        appTTSMock,
        setUserFavoritesUseCaseMock,
        authServiceMock,
        getUserFavoritesUseCaseMock,
      );
    });


    test('initial state should be CompleteWordInitialState', () {
      expect(completelyWordCubit.state, equals(CompleteWordInitialState()));
    });

    blocTest<CompletelyWordCubit, CompletelyWordState>(
      'emits CompleteWordSuccessState when getCompletelyWord is successful',
      build: () {
        when(() => getCompletelyWordUseCaseMock.call(any()))
            .thenAnswer((_) async => Right(completelyWord));
        when(() => saveCompletelyWordUseCaseMock.call(completelyWord))
            .thenAnswer((_) async => const Right(true));
        when(() => getUserFavoritesUseCaseMock.call(any()))
            .thenAnswer((_) async => Right(userFavorites));

        TestWidgetsFlutterBinding.ensureInitialized();
        return completelyWordCubit;
      },
      act: (cubit) => cubit.getCompletelyWord(word),
      expect: () => [
        isA<CompleteWordLoadingState>(),
        isA<CompleteWordSuccessState>(),
      ],
    );


    blocTest<CompletelyWordCubit, CompletelyWordState>(
      'emits CompleteWordErrorState when getCompletelyWord is fail',
      build: () {
        when(() => getCompletelyWordUseCaseMock.call(any()))
            .thenAnswer((_) async => Left(CompletelyWordDataSourceError()));
        when(() => getUserFavoritesUseCaseMock.call(any()))
            .thenAnswer((_) async => Right(userFavorites));
        TestWidgetsFlutterBinding.ensureInitialized();
        return completelyWordCubit;
      },
      act: (cubit) => cubit.getCompletelyWord(word),
      expect: () => [
        isA<CompleteWordLoadingState>(),
        isA<CompleteWordErrorState>(),
      ],
    );

    blocTest<CompletelyWordCubit, CompletelyWordState>(
      'calls setUserFavoritesUseCase when setFavorites is called',
      build: () {
        when(() => setUserFavoritesUseCaseMock.call(
            completelyWordCubit.getUserId(), 'word')).thenAnswer(
          (_) async => const Right(true),
        );

        return completelyWordCubit;
      },
      act: (cubit) => cubit.setFavorites('word'),
    );

    test('calls ttsService ', () {
      completelyWordCubit.speak('word');
    });

    tearDown(() {
      completelyWordCubit.close();
    });
  });
}
