import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:words/dictionary/data/model/models.dart';

main(){

  late Pronunciation pronunciation;

  test("Should be return Pronunciation class Instance", () async
  {
    pronunciation = Pronunciation.fromJson(jsonDecode(pronunciationJson));

    expect(pronunciation.all, "ɪɡ'zæmpəl");
  });

  test(
      'Should be return a JSON reference Pronunciation class instance ...',
          () async {
            pronunciation =
            Pronunciation.fromJson(jsonDecode(pronunciationJson));
        expect(pronunciation.toJson(), jsonDecode(pronunciationJson));
      });

}

const pronunciationJson = '''
 {
    "all": "ɪɡ'zæmpəl"
  }
''';