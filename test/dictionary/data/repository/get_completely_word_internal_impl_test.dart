import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:words/dictionary/data/model/models.dart';
import 'package:words/dictionary/domain/error/failure_dictionary.dart';
import 'package:words/dictionary/data/datasource/get_completely_word_datasource.dart';
import 'package:words/dictionary/data/repository/get_completely_word_internal_impl.dart';

class DoGetCompletelyWordDataSourceMock extends Mock
    implements IDoGetCompletelyWordDataSource {}

void main() {
  late GetCompletelyWordInternalImpl getCompletelyWordInternalImpl;
  late IDoGetCompletelyWordDataSource doGetCompletelyWordDataSourceMock;
  late CompletelyWord completelyWord;
  late String word;
  setUp(() {
    doGetCompletelyWordDataSourceMock = DoGetCompletelyWordDataSourceMock();
    getCompletelyWordInternalImpl =
        GetCompletelyWordInternalImpl(doGetCompletelyWordDataSourceMock);
    completelyWord = CompletelyWord();
    word = 'word';
  });

  test(' return CompletelyWord()', () async {

    when(() =>doGetCompletelyWordDataSourceMock.doGetCompletelyWord(word))
        .thenAnswer((_) async => completelyWord);

    final result =
    await getCompletelyWordInternalImpl.getCompletelyWordInternal(word);

    expect(
        result.fold((failure) => failure, (completelyWord) => completelyWord),
        isA<CompletelyWord>());
  });

  test(' Should return CompletelyWordDataSourceError() when call to dataSource', () async {

    final failure = CompletelyWordDataSourceError(message: 'Erro');

    when(() => doGetCompletelyWordDataSourceMock.doGetCompletelyWord(word)).thenThrow(failure);

    final result =
    await getCompletelyWordInternalImpl.getCompletelyWordInternal(word);
    expect(
        result.fold((failure) => failure, (completelyWord) => completelyWord),
        isA<CompletelyWordDataSourceError>());
  });

}
