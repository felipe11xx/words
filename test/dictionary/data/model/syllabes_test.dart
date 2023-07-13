import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:words/dictionary/data/model/models.dart';

main(){

  late Syllables syllables;

  test("Should be return Syllables class Instance", () async
  {
    syllables = Syllables.fromJson(jsonDecode(syllablesJson));

    expect(syllables.count, 3);
    expect(syllables.list, isA<List<String>>());
  });

  test(
      'Should be return a JSON reference Syllables class instance ...',
          () async {
            syllables =
            Syllables.fromJson(jsonDecode(syllablesJson));
        expect(syllables.toJson(), jsonDecode(syllablesJson));
      });

}

const syllablesJson = '''
 {
    "count": 3,
    "list": [
      "ex",
      "am",
      "ple"
    ]
  }
''';