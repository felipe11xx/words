import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:words/shared/services/hive_service.dart';
import 'package:words/user_history/data/model/user_history.dart';
import 'package:words/user_history/domain/error/failure_user_history.dart';
import 'package:words/user_history/internal/get_user_datasource_internal.dart';

class HiveServiceMock extends Mock implements HiveService {}
class BoxMock extends Mock implements Box {}

void main() {
  late DoGetUserHistoryDatasourceInternal datasource;
  late HiveService hiveServiceMock;
  late Box boxMock;
  late String userId;
  late  UserHistory userHistory;
  setUp(() {
    hiveServiceMock = HiveServiceMock();
    boxMock = BoxMock();
    datasource = DoGetUserHistoryDatasourceInternal(hiveServiceMock);
     userId = 'user123';
     userHistory = UserHistory(userId: userId, wordHistory: []);
  });

  group('doGetUserHistory', () {

    test('should return UserHistory when data is available in the box', () async {

      when(()=>hiveServiceMock.openBox('userHistory')).thenAnswer((_) async => boxMock);
      when(()=>boxMock.get(userId)).thenReturn(userHistory);

      final result = await datasource.doGetUserHistory(userId);

      expect(result, equals(userHistory));
      verify(()=>hiveServiceMock.openBox('userHistory')).called(1);
      verify(()=>boxMock.get(userId)).called(1);
    });

    test('should throw UserHistoryDataSourceError when an error occurs', () async {
      final error = Exception('Test Error');

      when(()=>hiveServiceMock.openBox('userHistory')).thenThrow(error);

      expect(() => datasource.doGetUserHistory(userId), throwsA(isA<UserHistoryDataSourceError>()));
      verify(()=>hiveServiceMock.openBox('userHistory')).called(1);
    });
  });
}

