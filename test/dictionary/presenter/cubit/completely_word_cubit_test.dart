
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

import 'package:words/shared/services/tts_service.dart';

class MockDoGetCompletelyWordUseCase extends Mock
    implements DoGetCompletelyWordUseCase {}

class MockDoSaveCompletelyWordUseCase extends Mock
    implements DoSaveCompletelyWordUseCase {}

class MockDoGetUserFavoritesUseCase extends Mock
    implements DoGetUserFavoritesUseCase {}

class MockDoSetUserFavoritesUseCase extends Mock
    implements DoSetUserFavoritesUseCase {}

class MockAuthService extends Mock implements AuthService {}

class MockAppTTS extends Mock implements AppTTS {}

void main() {
  group('CompletelyWordCubit', () {
    late CompletelyWordCubit completelyWordCubit;
    late MockDoGetCompletelyWordUseCase mockWordUseCase;
    late MockDoSaveCompletelyWordUseCase mockSaveCompletelyWordUseCase;
    late MockAppTTS mockTTS;
    late MockDoSetUserFavoritesUseCase mockSetUserFavoritesUseCase;
    late MockDoGetUserFavoritesUseCase mockGetUserFavoritesUseCase;
    late MockAuthService mockAuthService;

    const word = 'test';

    final completelyWord = CompletelyWord(results: [
      Results(definition: 'Definition 1'),
      Results(definition: 'Definition 2'),
    ]);

    final completelyWordDataSourceError = CompletelyWordDataSourceError(message: 'Failed to get completely word');

    setUp(() {
      mockWordUseCase = MockDoGetCompletelyWordUseCase();
      mockSaveCompletelyWordUseCase = MockDoSaveCompletelyWordUseCase();
      mockTTS = MockAppTTS();
      mockSetUserFavoritesUseCase = MockDoSetUserFavoritesUseCase();
      mockGetUserFavoritesUseCase = MockDoGetUserFavoritesUseCase();
      mockAuthService = MockAuthService();

      completelyWordCubit = CompletelyWordCubit(
        mockWordUseCase,
        mockSaveCompletelyWordUseCase,
        mockTTS,
        mockSetUserFavoritesUseCase,
        mockAuthService,
        mockGetUserFavoritesUseCase,
      );
    });

    test('emits CompleteWordSuccessState when getCompletelyWord is successful', () async {
      when(() => mockWordUseCase.call(any())).thenAnswer((_) async => Right(completelyWord));

      await completelyWordCubit.getCompletelyWord(word);

      expect(
        completelyWordCubit.stream,
        emitsInOrder([
          CompleteWordLoadingState(true),
          CompleteWordSuccessState(
            completelyWord,
            const ['Definition 1', 'Definition 2'],
            false,
          ),
        ]),
      );
    });

    test('emits CompleteWordErrorState when getCompletelyWord fails', () async {
      when(()=>mockWordUseCase.call(any())).thenAnswer((_) async => Left(completelyWordDataSourceError));

      await completelyWordCubit.getCompletelyWord(word);

      expect(
        completelyWordCubit.stream,
        emitsInOrder([
          CompleteWordLoadingState(true),
          CompleteWordErrorState(completelyWordDataSourceError),
        ]),
      );
    });

    test('calls saveCompletelyWordUseCase when getCompletelyWord is successful', () async {
      when(mockWordUseCase.call(any as String?) as Function()).thenAnswer((_) async => Right(completelyWord));

      await completelyWordCubit.getCompletelyWord(word);

      verify(mockSaveCompletelyWordUseCase.call(completelyWord) as Function()).called(1);
    });

    test('calls tts.speakEN when speak is called', () {
      const testWord = 'test';

      completelyWordCubit.speak(testWord);

      verify(mockTTS.speakEN(testWord)).called(1);
    });

    test('calls getUserFavoritesUseCase when _isFavorite is called', () async {
      when(mockGetUserFavoritesUseCase.call(any as String) as Function())
          .thenAnswer((_) async => Right(UserFavorites(wordsFavorites: ['favorite'], userId: '')));

      await completelyWordCubit.isFavorite(word);

      verify(mockGetUserFavoritesUseCase.call(completelyWordCubit.getUserId()) as Function()).called(1);
    });

    test('calls setUserFavoritesUseCase when setFavorites is called', () {
      const testWord = 'test';

      completelyWordCubit.setFavorites(testWord);

      verify(mockSetUserFavoritesUseCase.call(completelyWordCubit.getUserId(), testWord) as Function()).called(1);
    });

    // test('returns the user ID when getUserId is called', () {
    //   const userId = 'user_id';
    //
    //   when(mockAuthService.userAuth as Function()).thenReturn(UserA(uid: userId));
    //
    //   expect(completelyWordCubit.getUserId(), userId);
    // });

    tearDown(() {
      completelyWordCubit.close();
    });
  });
}
