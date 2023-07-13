import 'package:flutter_test/flutter_test.dart';
import 'package:words/user_history/data/model/user_history.dart';

main(){

  late UserHistory userHistory;

  test("Should be return UserHistory class Instance", () async
  {
    userHistory = UserHistory(userId: 'id',wordHistory: ['word']);

    expect(userHistory.userId,'id');
    expect(userHistory.wordHistory, isA<List<String>>());
  });


}
