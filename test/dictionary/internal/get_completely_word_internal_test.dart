import 'dart:convert';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';
import 'package:words/dictionary/data/model/completely_word.dart';
import 'package:words/dictionary/internal/get_completely_word_internal.dart';
import 'package:path/path.dart' as path;

class HiveInterfaceMock extends Mock implements HiveInterface {}

class BoxMock extends Mock implements Box {}

void main() {
  late DoGetCompletelyWordInternalDatasource doGetCompletelyWordInternalDatasource;
  late HiveInterface mockHiveInterface;
  late Box mockBox;
  late String word;
  late CompletelyWord completelyWord;

  setUp(()async {
    mockHiveInterface = HiveInterfaceMock();
    mockBox = BoxMock();
    doGetCompletelyWordInternalDatasource =
        DoGetCompletelyWordInternalDatasource();
    // Obtenha o diretório temporário para o Hive
    final tempDir = await getTemporaryDirectory();
    final hiveDir = path.join(tempDir.path, 'hive');

    // Inicialize o Hive com o diretório temporário
     Hive.init(hiveDir);
     word = 'test';
    completelyWord = CompletelyWord.fromJson(jsonDecode(completelyWordJson));

  });

  tearDown(()async{
    // Limpe o Hive e exclua o diretório temporário após cada teste
    await Hive.close();
    final tempDir = await getTemporaryDirectory();
    final hiveDir = path.join(tempDir.path, 'hive');
    await Hive.deleteBoxFromDisk('completelyWord');
    await Directory(hiveDir).delete(recursive: true);
  });

  test('doGetCompletelyWord retorna CompletelyWord quando o Hive retorna um valor', () async {

     TestWidgetsFlutterBinding.ensureInitialized();
    // Configure o comportamento esperado para o mock do Box
    when(() =>mockBox.get(any())).thenReturn(completelyWordJson);

    // Chame o método que você deseja testar
    final result = await doGetCompletelyWordInternalDatasource.doGetCompletelyWord(word);

    // Verifique o resultado esperado
    expect(result, completelyWord);
    verify(mockBox.get(word));
  });


  // test('doGetCompletelyWord retorna CompletelyWord when Hive Return a data', () async {
  //   TestWidgetsFlutterBinding.ensureInitialized();
  //
  //   when(()=> mockHiveInterface.openBox(any())).thenAnswer((_) async => mockBox);
  //   when(()=> mockBox.get(any())).thenReturn(completelyWordJson);
  //
  //   final result = await doGetCompletelyWordInternalDatasource.doGetCompletelyWord(word);
  //   expect(result, completelyWord);
  //   verify(()=>mockHiveInterface.openBox('completelyWord'));
  //   verify(()=>mockBox.get(word));
  // });

  // test('doGetCompletelyWord lança CompletelyWordDataSourceError quando ocorre um erro no Hive', () async {
  //   // Defina os valores de entrada e saída esperados
  //   final word = 'test';
  //   final expectedError = CompletelyWordDataSourceError(message: 'Erro no Hive');
  //
  //   // Configure o comportamento esperado para o mock do HiveInterface
  //   when(mockHiveInterface.openBox(any)).thenThrow(Exception());
  //
  //   // Chame o método que você deseja testar
  //   expect(() => doGetCompletelyWordInternalDatasource.doGetCompletelyWord(word), throwsA(expectedError));
  // });

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