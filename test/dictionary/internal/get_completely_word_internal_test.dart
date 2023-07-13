import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:words/shared/services/hive_service.dart';
import 'package:words/dictionary/data/model/completely_word.dart';
import 'package:words/dictionary/domain/error/failure_dictionary.dart';
import 'package:words/dictionary/internal/get_completely_word_internal.dart';

class HiveServiceMock extends Mock implements HiveService {}
class BoxMock extends Mock implements Box {}

void main() {
  late DoGetCompletelyWordInternalDatasource datasource;
  late HiveService hiveServiceMock;
  late Box boxMock;
  late CompletelyWord completelyWord;
  setUp(() {
    hiveServiceMock = HiveServiceMock();
    boxMock = BoxMock();
    datasource = DoGetCompletelyWordInternalDatasource(hiveServiceMock) ;
    completelyWord = CompletelyWord.fromJson(jsonDecode(completelyWordJson));
  });

  group('doGetUserHistory', () {

    test('should return CompletelyWord when data is available in the box', () async {

      when(()=>hiveServiceMock.openBox('completelyWord')).thenAnswer((_) async => boxMock);
      when(()=>boxMock.get('example')).thenReturn(completelyWord.toJson());

      final result = await datasource.doGetCompletelyWord('example');

      expect(result, isA<CompletelyWord>());
      verify(()=>hiveServiceMock.openBox('completelyWord')).called(1);
      verify(()=>boxMock.get('example')).called(1);
    });

    test('should throw CompletelyWordDataSourceError when an error occurs', () async {
      final error = Exception('Test Error');

      when(()=>hiveServiceMock.openBox('completelyWord')).thenThrow(error);

      expect(() => datasource.doGetCompletelyWord('example'), throwsA(isA<CompletelyWordDataSourceError>()));
      verify(()=>hiveServiceMock.openBox('completelyWord')).called(1);
    });
  });
}

const completelyWordJson = '''
{
  "word": "example",
  "results": [
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
    },
    {
      "definition": "something to be imitated",
      "partOfSpeech": "noun",
      "synonyms": [
        "exemplar",
        "good example",
        "model"
      ],
      "typeOf": [
        "ideal"
      ],
      "hasTypes": [
        "pacemaker",
        "pattern",
        "beauty",
        "prodigy",
        "beaut",
        "pacesetter"
      ],
      "derivation": [
        "exemplify",
        "exemplary"
      ],
      "examples": [
       
      ]
    },
    {
      "definition": "an occurrence of something",
      "partOfSpeech": "noun",
      "synonyms": [
        "case",
        "instance"
      ],
      "typeOf": [
        "happening",
        "natural event",
        "occurrence",
        "occurrent"
      ],
      "hasTypes": [
        "clip",
        "mortification",
        "piece",
        "time",
        "humiliation",
        "bit"
      ],
      "derivation": [
        "exemplify"
      ],
      "examples": [
        "but there is always the famous example of the Smiths"
      ]
    },
    {
      "definition": "an item of information that is typical of a class or group",
      "partOfSpeech": "noun",
      "synonyms": [
        "illustration",
        "instance",
        "representative"
      ],
      "typeOf": [
        "information"
      ],
      "hasTypes": [
        "excuse",
        "apology",
        "specimen",
        "case in point",
        "sample",
        "exception",
        "quintessence",
        "precedent"
      ],
      "derivation": [
        "exemplify",
        "exemplary"
      ],
      "examples": [
        "this patient provides a typical example of the syndrome",
        "there is an example on page 10"
      ]
    },
    {
      "definition": "punishment intended as a warning to others",
      "partOfSpeech": "noun",
      "synonyms": [
        "deterrent example",
        "lesson",
        "object lesson"
      ],
      "typeOf": [
        "monition",
        "admonition",
        "word of advice",
        "warning"
      ],
      "hasTypes": [],
      "derivation": [
        "exemplary"
      ],
      "examples": [
        "they decided to make an example of him"
      ]
    },
    {
      "definition": "a task performed or problem solved in order to develop skill or understanding",
      "partOfSpeech": "noun",
      "synonyms": [
        "exercise"
      ],
      "hasTypes": [],
      "derivation": [],
      "typeOf": [
        "lesson"
      ],
      "examples": [
        "you must work the examples at the end of each chapter in the textbook"
      ]
    }
  ],
  "syllables": {
    "count": 3,
    "list": [
      "ex",
      "am",
      "ple"
    ]
  },
  "pronunciation": {
    "all": "ɪɡ'zæmpəl"
  },
  "frequency": 4.67
}
''';

