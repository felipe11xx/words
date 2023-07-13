import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:words/dictionary/data/model/models.dart';
import 'package:words/dictionary/domain/error/failure_dictionary.dart';
import 'package:words/dictionary/domain/usecase/do_get_completely_word_usecase.dart';
import 'package:words/dictionary/domain/repositories/get_completely_word_repository.dart';
import 'package:words/dictionary/domain/repositories/get_completely_word_internal_repository.dart';

class GetCompletelyWordRepositoryMock extends Mock
    implements IGetCompletelyWordRepository {}

class GetCompletelyWordInternalRepositoryMock extends Mock
    implements IGetCompletelyWordInternalRepository {}

void main() {
  late DoGetCompletelyWordUseCase doGetCompletelyWordUseCase;
  late IGetCompletelyWordRepository getCompletelyWordRepositoryMock;
  late IGetCompletelyWordInternalRepository getCompletelyWordInternalRepositoryMock;
  late CompletelyWord completelyWord;
  late String word;
  setUp(() {

    getCompletelyWordRepositoryMock = GetCompletelyWordRepositoryMock();
    getCompletelyWordInternalRepositoryMock = GetCompletelyWordInternalRepositoryMock();
    doGetCompletelyWordUseCase = DoGetCompletelyWordUseCase(
      getCompletelyWordRepositoryMock,
      getCompletelyWordInternalRepositoryMock,
    );
    completelyWord = CompletelyWord();
    word = 'word';
  });

  test('Should return CompletelyWord when call getCompletelyWordInternalRepository  is success', () async {

    when(() => getCompletelyWordInternalRepositoryMock.getCompletelyWordInternal(word))
        .thenAnswer((_) async => Right(completelyWord));

    final result = await doGetCompletelyWordUseCase.call(word);

    expect(result,  Right(completelyWord));
    verifyNever( () => getCompletelyWordRepositoryMock.getCompletelyWord(word));
  });

  test('Should return CompletelyWord when call getCompletelyWordRepository and getCompletelyWordInternalRepository fail', () async {

    when(() => getCompletelyWordInternalRepositoryMock.getCompletelyWordInternal(word))
        .thenAnswer((_) async => Left(CompletelyWordDataSourceError(message: 'error')));

    when( ()=> getCompletelyWordRepositoryMock.getCompletelyWord(word))
        .thenAnswer((_) async => Right(completelyWord));

    final result = await doGetCompletelyWordUseCase.call(word);

    expect(result, Right(completelyWord));
    verify(() => getCompletelyWordInternalRepositoryMock.getCompletelyWordInternal(word));
    verify(() => getCompletelyWordRepositoryMock.getCompletelyWord(word));
  });

}
