import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:words/user_History/data/model/user_History.dart';
import 'package:words/user_history/domain/error/failure_user_history.dart';
import 'package:words/user_history/domain/usecase/do_save_user_history_usecase.dart';
import 'package:words/user_history/domain/repository/save_user_history_repository.dart';

class SaveUserHistoryRepositoryMock extends Mock implements ISaveUserHistoryRepository {}

void main() {
  late DoSaveUserHistoryUseCase useCase;
  late ISaveUserHistoryRepository repositoryMock;
  late UserHistory userHistory;

  setUp(() {
    repositoryMock = SaveUserHistoryRepositoryMock();
    useCase = DoSaveUserHistoryUseCase(repositoryMock);
    userHistory = UserHistory(userId: "123", wordHistory: ['word']);

  });

  group('DoSaveUserHistoryUseCase', () {


    test('should return true when repository saves user history successfully', () async {
      when(() => repositoryMock.saveUserHistory(userHistory.userId, 'word')).thenAnswer((_) async => const Right(true));

      final result = await useCase.call(userHistory.userId, 'word');

      expect(result, equals(const Right(true)));
      verify(() => repositoryMock.saveUserHistory(userHistory.userId, 'word')).called(1);
    });

    test('should return FailureUserHistory when repository returns a failure', () async {
      final failure = UserHistoryDataSourceError(message: 'Test Failure');
      when(() => repositoryMock.saveUserHistory(userHistory.userId, 'word')).thenAnswer((_) async => Left(failure));

      final result = await useCase.call(userHistory.userId, 'word');

      expect(result, equals(Left(failure)));
      verify(() => repositoryMock.saveUserHistory(userHistory.userId, 'word')).called(1);
    });
  });
}
