import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:words/dictionary/data/model/models.dart';

main(){

  late Results results;

  test("Should be return Results class Instance", () async
  {
    results = Results.fromJson(jsonDecode(resultsJson));

     expect(results.definition, "a representative form or pattern");
     expect(results.partOfSpeech, "noun");
     expect(results.synonyms, isA<List<String>>());
     expect(results.typeOf, isA<List<String>>());
     expect(results.hasTypes, isA<List<String>>());
     expect(results.derivation, isA<List<String>>());
     expect(results.examples, isA<List<String>>());
  });

  test(
      'Should be return a JSON reference Results class instance ...',
          () async {
            results =
                Results.fromJson(jsonDecode(resultsJson));
        expect(results.toJson(), jsonDecode(resultsJson));
      });

}

const resultsJson = '''
    {
      "definition": "a representative form or pattern",
      "partOfSpeech": "noun",
      "synonyms": [
        "model"
      ],
      "typeOf": [
        "representation",
        "internal representation",
        "mental representation"
      ],
      "hasTypes": [
        "prefiguration",
        "archetype",
        "epitome",
        "guide",
        "holotype",
        "image",
        "loadstar",
        "lodestar",
        "microcosm",
        "original",
        "paradigm",
        "pilot",
        "prototype",
        "template",
        "templet",
        "type specimen"
      ],
      "derivation": [
        "exemplify"
      ],
      "examples": [
        "I profited from his example"
      ]
    }
''';