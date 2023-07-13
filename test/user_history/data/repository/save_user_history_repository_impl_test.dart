
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:words/user_history/data/model/user_history.dart';
import 'package:words/user_history/domain/error/failure_user_history.dart';
import 'package:words/user_history/domain/repository/save_user_history_repository.dart';
import 'package:words/user_history/domain/usecase/do_save_user_history_usecase.dart';

class SaveCompletelyWordRepositoryMock extends Mock
    implements ISaveUserHistoryRepository {}

void main() {
  late DoSaveUserHistoryUseCase doSaveUserHistoryUseCase;
  late ISaveUserHistoryRepository saveUserHistoryRepositoryMock;
  late UserHistory userHistory;

  setUp(() {
    saveUserHistoryRepositoryMock = SaveCompletelyWordRepositoryMock();
    doSaveUserHistoryUseCase =
        DoSaveUserHistoryUseCase(saveUserHistoryRepositoryMock);
    userHistory = UserHistory(userId: '123', wordHistory: ['word']);
  });

  test('Should return True  when call SaveUserHistoryRepository  is success', () async {
    when(() => saveUserHistoryRepositoryMock.saveUserHistory(userHistory.userId,'word'))
        .thenAnswer((_) async => const Right(true));

    final result = await doSaveUserHistoryUseCase.call(userHistory.userId,'word');

    expect(result, const Right(true));
  });

  test('Should return UserHistoryDataSourceError  when call SaveUserHistoryRepository  is fail', () async {
    final failure = UserHistoryDataSourceError(message: 'any_error');
    when(() => saveUserHistoryRepositoryMock.saveUserHistory(userHistory.userId, 'word'))
        .thenAnswer((_)async=>Left(failure));

    final result = await doSaveUserHistoryUseCase.call(userHistory.userId,'word');
    expect(result.fold((failure) => failure, (r) => r),
        failure);
  });

}
