import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:words/home/presenter/cubit/all_words_cubit.dart';
import 'package:words/home/presenter/cubit/cubits.dart';
import 'package:words/shared/services/auth_service.dart';
import 'package:words/shared/services/real_time_data_base_service.dart';
import 'package:words/user_history/domain/usecase/do_save_user_history_usecase.dart';

class RealTimeDataBaseServiceMock extends Mock implements RealTimeDataBaseService {}
class DoSaveUserHistoryUseCaseMock extends Mock implements DoSaveUserHistoryUseCase {}
class AuthServiceMock extends Mock implements AuthService {}
class QueryMock extends Mock implements Query {}

void main() {
  late AllWordsCubit allWordsCubit;
  late RealTimeDataBaseServiceMock mockRealTimeDataBaseService;
  late DoSaveUserHistoryUseCaseMock doSaveUserHistoryUseCaseMock;
  late AuthServiceMock mockAuthService;

  setUp(() {
    mockRealTimeDataBaseService = RealTimeDataBaseServiceMock();
    doSaveUserHistoryUseCaseMock = DoSaveUserHistoryUseCaseMock();
    mockAuthService = AuthServiceMock();
    allWordsCubit = AllWordsCubit(mockRealTimeDataBaseService, doSaveUserHistoryUseCaseMock, mockAuthService);
  });

  group('AllWordsCubit', () {

    test('initial state should be AllWordsStateInitialState', () {
      expect(allWordsCubit.state, equals(AllWordsStateInitialState()));
    });


    test('getWordsQuery should return the query from RealTimeDataBaseService', () {
      final mockQuery = QueryMock();
      when(() => mockRealTimeDataBaseService.getWordsQuery).thenReturn(mockQuery);

      final result = allWordsCubit.getWordsQuery();

      expect(result, equals(mockQuery));
      verify(() => mockRealTimeDataBaseService.getWordsQuery).called(1);
    });

    blocTest<AllWordsCubit, AllWordsState>(
      'saveUserHistory should call the DoSaveUserHistoryUseCase',
      build: () {
        when(() => doSaveUserHistoryUseCaseMock.call(
            allWordsCubit.getUserId(), 'word')).thenAnswer(
              (_) async => const Right(true),
        );

        return allWordsCubit;
      },
      act: (cubit) => cubit.saveUserHistory('word'),
    );

  });
}

