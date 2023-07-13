import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:words/shared/services/hive_service.dart';
import 'package:words/user_favorites/data/model/user_favorites.dart';
import 'package:words/user_favorites/domain/error/failure_user_favorites.dart';
import 'package:words/user_favorites/internal/get_user_favorite_datasource_internal.dart';

class HiveServiceMock extends Mock implements HiveService {}
class BoxMock extends Mock implements Box {}

void main() {

  late DoGetUserFavoritesDatasourceInternal datasource;
  late HiveService hiveServiceMock;
  late Box boxMock;
  late String userId;
  late  UserFavorites userFavorites;
  setUp(() {
    hiveServiceMock = HiveServiceMock();
    boxMock = BoxMock();
    datasource = DoGetUserFavoritesDatasourceInternal(hiveServiceMock);
     userId = 'user123';
    userFavorites = UserFavorites(userId: userId, wordsFavorites: []);
  });

  group('doGetUserFavorites', () {

    test('should return UserFavorites when data is available in the box', () async {

      when(()=>hiveServiceMock.openBox('userFavorites')).thenAnswer((_) async => boxMock);
      when(()=>boxMock.get(userId)).thenReturn(userFavorites);

      final result = await datasource.doGetUserFavorites(userId);

      expect(result, equals(userFavorites));
      verify(()=>hiveServiceMock.openBox('userFavorites')).called(1);
      verify(()=>boxMock.get(userId)).called(1);
    });

    test('should throw UserFavoritesDataSourceError when an error occurs', () async {
      final error = Exception('Test Error');

      when(()=>hiveServiceMock.openBox('userFavorites')).thenThrow(error);

      expect(() => datasource.doGetUserFavorites(userId), throwsA(isA<UserFavoritesDataSourceError>()));
      verify(()=>hiveServiceMock.openBox('userFavorites')).called(1);
    });
  });
}

