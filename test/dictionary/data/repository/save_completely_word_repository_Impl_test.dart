import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:words/dictionary/data/model/models.dart';
import 'package:words/dictionary/domain/error/failure_dictionary.dart';
import 'package:words/dictionary/data/datasource/save_completely_word_datasource.dart';
import 'package:words/dictionary/data/repository/save_completely_word_repository_impl.dart';

class SaveCompleteWordDataSourceMock extends Mock
    implements ISaveCompleteWordDataSource {}

void main() {
  late SaveCompletelyWordImpl saveCompletelyWordImpl;
  late ISaveCompleteWordDataSource saveCompleteWordDataSourceMock;
  late CompletelyWord completelyWord;
  late bool expectedResult;
  setUp(() {
    saveCompleteWordDataSourceMock = SaveCompleteWordDataSourceMock();
    saveCompletelyWordImpl = SaveCompletelyWordImpl(saveCompleteWordDataSourceMock);
    completelyWord = CompletelyWord();

    expectedResult = true;
  });

  test('Should save CompletelyWord()', () async {
    when(()=>saveCompleteWordDataSourceMock.saveCompletelyWord(completelyWord))
        .thenAnswer((_) async => expectedResult);

    final result =
    await saveCompletelyWordImpl.saveCompletelyWord(completelyWord);

    expect(result, Right(expectedResult));

    expect(
        result.fold((failure) => failure, (completelyWord) => completelyWord),
        isA<bool>());
  });

  test('Should return CompletelyWordDataSourceError() when call to dataSource throw a exception', () async {

    final expectedError = SaveCompletelyWordDataSourceError(message: 'Erro');

    when(()=>saveCompleteWordDataSourceMock.saveCompletelyWord(completelyWord)).thenThrow(expectedError);

    final result =
    await saveCompletelyWordImpl.saveCompletelyWord(completelyWord);

    expect(
        result.fold((failure) => failure, (completelyWord) => completelyWord),
        isA<SaveCompletelyWordDataSourceError>());
  });

}
