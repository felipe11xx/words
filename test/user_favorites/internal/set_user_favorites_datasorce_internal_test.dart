import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:words/shared/services/hive_service.dart';
import 'package:words/user_favorites/data/model/user_favorites.dart';
import 'package:words/user_favorites/domain/error/failure_user_favorites.dart';
import 'package:words/user_favorites/internal/set_user_favorites_datasource_internal.dart';

class MockHiveService extends Mock implements HiveService {}
class BoxMock extends Mock implements Box {}

void main() {
  late DoSetUserFavoritesDatasourceInternal datasource;
  late MockHiveService mockHiveService;
  late Box boxMock;
  late String userId;
  late  UserFavorites userFavorites;
  setUp(() {
    mockHiveService = MockHiveService();
    datasource = DoSetUserFavoritesDatasourceInternal(mockHiveService);
    boxMock = BoxMock();
    userId = 'user123';
    userFavorites = UserFavorites(userId: userId, wordsFavorites: []);
  });

  group('DoSetUserFavoritesDatasourceInternal', () {


    test('should set user favorites successfully when new word is add', () async {

      when(() => mockHiveService.openBox('userFavorites')).thenAnswer((_) async => boxMock);
      when(()=> boxMock.get(userId)).thenReturn(userFavorites);
      when(()=> boxMock.put(userId,userFavorites)).thenAnswer((_)async => true );

      final result = await datasource.setUserFavorites(userId, 'word');

      expect(result, equals(true));
      verify(() => mockHiveService.openBox('userFavorites')).called(1);
    });

    test('should set user favorites successfully when word is repeated ', () async {
      userFavorites.wordsFavorites.add('word');
      when(() => mockHiveService.openBox('userFavorites')).thenAnswer((_) async => boxMock);
      when(()=> boxMock.get(userId)).thenReturn(userFavorites);
      when(()=> boxMock.put(userId,userFavorites)).thenAnswer((_)async => true );

      final result = await datasource.setUserFavorites(userId, 'word');

      expect(result, equals(true));
      verify(() => mockHiveService.openBox('userFavorites')).called(1);
    });

    //Todo fix this later
    // test('should set user favorites successfully userFavorites does not exist ', () async {
    //
    //   when(() => mockHiveService.openBox('userFavorites')).thenAnswer((_) async => boxMock);
    //   when(()=> boxMock.get(userId)).thenReturn(null);
    //   when(()=> boxMock.put(userId,userFavorites)).thenAnswer((_)async => true );
    //
    //   final result = await datasource.setUserFavorites(userId, 'word');
    //
    //   expect(result, equals(true));
    //   verify(() => mockHiveService.openBox('userFavorites')).called(1);
    // });


    test('should throw UserFavoritesDataSourceError when an error occurs', () async {
      when(() => mockHiveService.openBox('userFavorites')).thenThrow(Exception());

      expect(
            () => datasource.setUserFavorites(userFavorites.userId, 'word'),
        throwsA(isA<UserFavoritesDataSourceError>()),
      );
      verify(() => mockHiveService.openBox('userFavorites')).called(1);
    });
  });
}
