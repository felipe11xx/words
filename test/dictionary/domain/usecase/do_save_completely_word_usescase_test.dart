
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:words/dictionary/data/model/models.dart';
import 'package:words/dictionary/domain/error/failure_dictionary.dart';
import 'package:words/dictionary/domain/repositories/save_completely_word_repository.dart';
import 'package:words/dictionary/domain/usecase/do_save_completely_word_usecase.dart';

class SaveCompletelyWordRepositoryMock extends Mock
    implements ISaveCompletelyWordRepository {}

void main() {
  late DoSaveCompletelyWordUseCase doSaveCompletelyWordUseCase;
  late ISaveCompletelyWordRepository saveCompletelyWordRepositoryMock;
  late CompletelyWord completelyWord;

  setUp(() {
    saveCompletelyWordRepositoryMock = SaveCompletelyWordRepositoryMock();
    doSaveCompletelyWordUseCase =
        DoSaveCompletelyWordUseCase(saveCompletelyWordRepositoryMock);
    completelyWord = CompletelyWord();
  });

  test('Should return True  when call saveCompletelyWordRepository  is success', () async {
    when(() => saveCompletelyWordRepositoryMock.saveCompletelyWord(completelyWord))
        .thenAnswer((_) async => const Right(true));

    final result = await doSaveCompletelyWordUseCase.call(completelyWord);

    expect(result, const Right(true));
  });

  test('Should return SaveCompletelyWordDataSourceError  when call saveCompletelyWordRepository  is fail', () async {
    final failure = SaveCompletelyWordDataSourceError(message: 'any_error');


    when(() => saveCompletelyWordRepositoryMock.saveCompletelyWord(completelyWord))
        .thenAnswer((_)async=>Left(failure));

    final result = await doSaveCompletelyWordUseCase.call(completelyWord);


    expect(result.fold((failure) => failure, (r) => r),
        failure);
  });

}
