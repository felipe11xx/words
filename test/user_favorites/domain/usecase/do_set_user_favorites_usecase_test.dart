import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:words/user_history/domain/error/failure_user_history.dart';
import 'package:words/user_history/domain/repository/save_user_history_repository.dart';
import 'package:words/user_history/domain/usecase/do_save_user_history_usecase.dart';

class MockSaveUserHistoryRepository extends Mock implements ISaveUserHistoryRepository {}

void main() {
  late DoSaveUserHistoryUseCase useCase;
  late MockSaveUserHistoryRepository mockRepository;

  setUp(() {
    mockRepository = MockSaveUserHistoryRepository();
    useCase = DoSaveUserHistoryUseCase(mockRepository);
  });

  group('DoSaveUserHistoryUseCase', () {
    const userId = 'user123';
    const word = 'example';

    test('should return true when repository saves user history successfully', () async {
      when(() => mockRepository.saveUserHistory(userId, word)).thenAnswer((_) async => Right(true));

      final result = await useCase.call(userId, word);

      expect(result, equals(Right(true)));
      verify(() => mockRepository.saveUserHistory(userId, word)).called(1);
    });

    test('should return FailureUserHistory when repository returns a failure', () async {
      final failure = UserHistoryDataSourceError(message: 'Test Failure');
      when(() => mockRepository.saveUserHistory(userId, word)).thenAnswer((_) async => Left(failure));

      final result = await useCase.call(userId, word);

      expect(result, equals(Left(failure)));
      verify(() => mockRepository.saveUserHistory(userId, word)).called(1);
    });
  });
}
