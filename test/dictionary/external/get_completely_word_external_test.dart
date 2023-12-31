import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:words/shared/network/custom_dio.dart';
import 'package:words/dictionary/data/model/models.dart';
import 'package:words/dictionary/domain/error/failure_dictionary.dart';
import 'package:words/dictionary/external/get_completely_word_external.dart';

class CustomDioMock extends Mock implements CustomDio {}

class RequestOptionsMock extends Mock implements RequestOptions {}

void main() {
  late DoGetCompletelyWordExternalDatasource
      doGetCompletelyWordExternalDatasource;
  late CustomDio mockCustomDio;
  late RequestOptions requestOptionsMock;

  late String word;

  setUp(() {
    mockCustomDio = CustomDioMock();
    requestOptionsMock = RequestOptionsMock();

    doGetCompletelyWordExternalDatasource =
        DoGetCompletelyWordExternalDatasource(mockCustomDio);
    word = 'word';
  });

  test(
      'Should return CompletelyWord when Dio returns',
      () async {
        TestWidgetsFlutterBinding.ensureInitialized();

        when(() => mockCustomDio.get(any())).thenAnswer((_) async => Response(
        data: jsonDecode(completelyWordJson),
        statusCode: 200,
        requestOptions: requestOptionsMock));

    final result =
        await doGetCompletelyWordExternalDatasource.doGetCompletelyWord(word);

    expect(result, isA<CompletelyWord>());
  });

  test('Should throw a Exeception when status code was not 200 ', () async {

    when(()=>mockCustomDio.get(any())).thenAnswer((_) async => Response(data: null, statusCode: 404, requestOptions: requestOptionsMock));

    expect(() => doGetCompletelyWordExternalDatasource.doGetCompletelyWord(word), throwsA(isA<CompletelyWordDataSourceError>()));
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
