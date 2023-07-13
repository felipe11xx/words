import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:words/dictionary/data/model/completely_word.dart';
import 'package:words/dictionary/domain/error/failure_dictionary.dart';
import 'package:words/dictionary/data/datasource/get_completely_word_datasource.dart';
import 'package:words/dictionary/data/repository/get_completely_word_external_impl.dart';

class IDoGetCompletelyWordDataSourceMock extends Mock
    implements IDoGetCompletelyWordDataSource {}

class RequestOptionsMock extends Mock implements RequestOptions {}

main() {
  late IDoGetCompletelyWordDataSource doGetCompletelyWordDataSource;
  late RequestOptions requestOptionsMock;
  late GetCompletelyWordExternalImpl getCompletelyWordExternalImpl;
  late CompletelyWord completelyWord;
  late String word;

  setUpAll(() {
    doGetCompletelyWordDataSource = IDoGetCompletelyWordDataSourceMock();
    requestOptionsMock = RequestOptionsMock();
    getCompletelyWordExternalImpl =
        GetCompletelyWordExternalImpl(doGetCompletelyWordDataSource);
    completelyWord = CompletelyWord();
    word = 'word';
  });

    test("Should return CompletelyWord()", () async {
      when(() => doGetCompletelyWordDataSource.doGetCompletelyWord(word)).thenAnswer((_) async => completelyWord);

      final result =
          await getCompletelyWordExternalImpl.getCompletelyWord(word);

      expect(
          result.fold((failure) => failure, (completelyWord) => completelyWord),
          isA<CompletelyWord>());
    });


    test("Should return CompletelyWordDataSourceError() when call to dataSource is error on http request", () async {
      when(() => doGetCompletelyWordDataSource.doGetCompletelyWord(word)).thenThrow(DioException(requestOptions: requestOptionsMock));

      final result =
          await getCompletelyWordExternalImpl.getCompletelyWord(word);

      expect(
          result.fold((failure) => failure, (completelyWord) => completelyWord),
          isA<CompletelyWordDataSourceError>());
    });

    test("Should return CompletelyWordDataSourceError() when call to dataSource throw a exception", () async {
      when(() => doGetCompletelyWordDataSource.doGetCompletelyWord(word)).thenThrow(Exception(any));

      final result =
          await getCompletelyWordExternalImpl.getCompletelyWord(word);

      expect(
          result.fold((failure) => failure, (completelyWord) => completelyWord),
          isA<CompletelyWordDataSourceError>());
    });

}
