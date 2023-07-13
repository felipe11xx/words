import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:words/user_history/data/model/user_history.dart';
import 'package:words/user_history/domain/error/failure_user_history.dart';
import 'package:words/user_history/data/datasource/get_user_history_datasource.dart';
import 'package:words/user_history/data/repository/get_user_history_repository_impl.dart';

class IDoGetUserHistoryDataSourceMock extends Mock
    implements IDoGetUserHistoryDataSource {}


main() {
  late IDoGetUserHistoryDataSource doGetUserHistoryDataSource;
  late GetUserHistoryInternalImpl getUserHistoryInternalImpl;
  late UserHistory userHistory;
  late String userId;

  setUpAll(() {
    doGetUserHistoryDataSource = IDoGetUserHistoryDataSourceMock();
    getUserHistoryInternalImpl =
        GetUserHistoryInternalImpl(doGetUserHistoryDataSource);
    userId = 'id';
    userHistory = UserHistory(userId: userId,wordHistory: ['word']);

  });

  test("Should return userHistory", () async {
    when(() => doGetUserHistoryDataSource.doGetUserHistory(userId)).thenAnswer((_) async => userHistory);

    final result =
    await getUserHistoryInternalImpl.getUserHistory(userId);

    expect(
        result.fold((failure) => failure, (userFavorites) => userFavorites),
        isA<UserHistory>());
  });



  test("Should return UserHistoryDataSourceError() when call to dataSource throw a exception", () async {
    when(() => doGetUserHistoryDataSource.doGetUserHistory(userId)).thenThrow(Exception(any));

    final result =
    await getUserHistoryInternalImpl.getUserHistory(userId);

    expect(
        result.fold((failure) => failure, (userFavorites) => userFavorites),
        isA<UserHistoryDataSourceError>());
  });

}
