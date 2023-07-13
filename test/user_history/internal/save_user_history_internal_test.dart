import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:words/shared/services/hive_service.dart';
import 'package:words/user_history/data/datasource/save_user_history_datasource.dart';
import 'package:words/user_history/data/model/user_history.dart';
import 'package:words/user_history/domain/error/failure_user_history.dart';
import 'package:words/user_history/internal/save_user_history_datasource_internal.dart';

class MockHiveService extends Mock implements HiveService {}
class BoxMock extends Mock implements Box {}

void main() {
  late DoSaveUserHistoryDatasourceInternal datasource;
  late MockHiveService mockHiveService;
  late Box boxMock;
  late String userId;
  late  UserHistory userHistory;
  setUp(() {
    mockHiveService = MockHiveService();
    boxMock = BoxMock();
    datasource = DoSaveUserHistoryDatasourceInternal(mockHiveService);
    userId = 'user123';
    userHistory = UserHistory(userId: userId, wordHistory: []);
  });

  group('DoSaveUserHistoryDatasourceInternal', () {


    test('should save user history successfully when new word is add', () async {

      when(() => mockHiveService.openBox('userHistory')).thenAnswer((_) async => boxMock);
      when(()=> boxMock.get(userId)).thenReturn(userHistory);
      when(()=> boxMock.put(userId,userHistory)).thenAnswer((_)async => true );

      final result = await datasource.saveUserHistory(userId, 'word');

      expect(result, equals(true));
      verify(() => mockHiveService.openBox('userHistory')).called(1);
    });

    test('should save user history successfully when word is repeated ', () async {
      userHistory.wordHistory.add('word');
      when(() => mockHiveService.openBox('userHistory')).thenAnswer((_) async => boxMock);
      when(()=> boxMock.get(userId)).thenReturn(userHistory);
      when(()=> boxMock.put(userId,userHistory)).thenAnswer((_)async => true );

      final result = await datasource.saveUserHistory(userId, 'word');

      expect(result, equals(true));
      verify(() => mockHiveService.openBox('userHistory')).called(1);
    });

    test('should throw UserHistoryDataSourceError when an error occurs', () async {
      when(() => mockHiveService.openBox('userHistory')).thenThrow(Exception());

      expect(
            () => datasource.saveUserHistory(userId, 'word'),
        throwsA(isA<UserHistoryDataSourceError>()),
      );
      verify(() => mockHiveService.openBox('userHistory')).called(1);
    });
  });
}
