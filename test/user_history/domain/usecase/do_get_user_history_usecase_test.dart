import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:words/user_history/data/model/user_history.dart';
import 'package:words/user_history/domain/error/failure_user_history.dart';
import 'package:words/user_history/domain/repository/get_user_history_repository.dart';
import 'package:words/user_history/domain/usecase/do_get_user_history_usecase.dart';

class GetUserHistoryRepositoryMock extends Mock implements IGetUserHistoryRepository {}

void main() {
  late DoGetUserHistoryUseCase useCase;
  late IGetUserHistoryRepository repositoryMock;
  late UserHistory userHistory;
  setUp(() {
    repositoryMock = GetUserHistoryRepositoryMock();
    useCase = DoGetUserHistoryUseCase(repositoryMock);
    userHistory = UserHistory(userId: "123", wordHistory: ['word']);
  });

  group('DoGetUserHistoryUseCase', () {

    test('should return user history when repository returns a result', () async {
      when(() => repositoryMock.getUserHistory(userHistory.userId)).thenAnswer((_) async => Right(userHistory));

      final result = await useCase.call(userHistory.userId);

      expect(result, equals(Right(userHistory)));
      verify(() => repositoryMock.getUserHistory(userHistory.userId)).called(1);
    });

    test('should return FailureUserHistory when repository returns a failure', () async {
      final failure = UserHistoryDataSourceError(message: 'Test Failure');
      when(() => repositoryMock.getUserHistory(userHistory.userId)).thenAnswer((_) async => Left(failure));

      final result = await useCase.call(userHistory.userId);

      expect(result, equals(Left(failure)));
      verify(() => repositoryMock.getUserHistory(userHistory.userId)).called(1);
    });
  });
}
