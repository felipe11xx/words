import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:words/shared/services/auth_service.dart';
import 'package:words/user_history/domain/error/failure_user_history.dart';
import 'package:words/user_history/presenter/cubit/cubits.dart';
import 'package:words/user_history/data/model/user_history.dart';
import 'package:words/user_history/domain/usecase/do_get_user_history_usecase.dart';

class DoGetUserHistoryUseCaseMock extends Mock implements DoGetUserHistoryUseCase {}

class AuthServiceMock extends Mock implements AuthService {}

class UserMock extends Mock implements User{
  @override
  String get uid => '123';
}

void main() {
  late HistoryCubit historyCubit;
  late DoGetUserHistoryUseCase doGetUserHistoryUseCaseMock;
  late AuthServiceMock authServiceMock;
  late UserHistory userHistory;
  setUp(() {
    doGetUserHistoryUseCaseMock = DoGetUserHistoryUseCaseMock();
    authServiceMock = AuthServiceMock();
    historyCubit = HistoryCubit(doGetUserHistoryUseCaseMock, authServiceMock);
    userHistory = UserHistory(userId: '123', wordHistory: ['word1','word2']);
  });

  group('HistoryCubit', () {

    test('initial state should be HistoryInitialState', () {
      expect(historyCubit.state, equals(HistoryInitialState()));
    });

    blocTest<HistoryCubit, HistoryState>(
      'getWords should emit HistoryLoadingState and HistorySuccessState on success',
      build: () {
        when(() => doGetUserHistoryUseCaseMock.call(any()))
            .thenAnswer((_) async =>  Right(userHistory));


        TestWidgetsFlutterBinding.ensureInitialized();
        return historyCubit;
      },
      act: (cubit) => cubit.getWords(),
      expect: () => [
        isA<HistoryLoadingState>(),
        isA<HistorySuccessState>(),
      ],
    );

    blocTest<HistoryCubit, HistoryState>(
      'getWords should emit HistoryErrorState on fails',
      build: () {

        when(() => doGetUserHistoryUseCaseMock.call(any()))
            .thenAnswer((_) async =>  Left(UserHistoryDataSourceError()));


        TestWidgetsFlutterBinding.ensureInitialized();
        return historyCubit;
      },
      act: (cubit) => cubit.getWords(),
      expect: () => [
        isA<HistoryLoadingState>(),
        isA<HistoryErrorState>(),
      ],
    );

    test('getUserId should return the correct user ID', () {

      when(() => authServiceMock.userAuth).thenReturn(UserMock());

      final result = historyCubit.getUserId();

      expect(result, equals('123'));
    });
  });
}
