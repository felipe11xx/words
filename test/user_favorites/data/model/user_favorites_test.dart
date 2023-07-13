
import 'package:flutter_test/flutter_test.dart';
import 'package:words/user_favorites/data/model/user_favorites.dart';

main(){

  late UserFavorites userFavorites;

  test("Should be return UserFavorites class Instance", () async
  {
    userFavorites = UserFavorites(userId: 'id',wordsFavorites: ['word']);

    expect(userFavorites.userId,'id');
    expect(userFavorites.wordsFavorites, isA<List<String>>());
  });


}
