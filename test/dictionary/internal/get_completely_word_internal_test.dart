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
  late HiveService mockHiveService;
  late Box boxMock;
  setUp(() {
    mockHiveService = HiveServiceMock();
    boxMock = BoxMock();
    datasource = DoGetUserHistoryDatasourceInternal(mockHiveService);
  });

  group('doGetUserHistory', () {
    const userId = 'user123';

    test('should return UserHistory when data is available in the box', () async {

      final userHistory = UserHistory(userId: '', wordHistory: []/* your user history data here */);

      when(()=>mockHiveService.openBox('userHistory')).thenAnswer((_) async => boxMock);
      when(()=>boxMock.get(userId)).thenReturn(userHistory);

      final result = await datasource.doGetUserHistory(userId);

      expect(result, equals(userHistory));
      verify(()=>mockHiveService.openBox('userHistory')).called(1);
      verify(()=>boxMock.get(userId)).called(1);
    });

    test('should throw UserHistoryDataSourceError when an error occurs', () async {
      final error = Exception('Test Error');

      when(()=>mockHiveService.openBox('userHistory')).thenThrow(error);

      expect(() => datasource.doGetUserHistory(userId), throwsA(isA<UserHistoryDataSourceError>()));
      verify(()=>mockHiveService.openBox('userHistory')).called(1);
    });
  });
}

