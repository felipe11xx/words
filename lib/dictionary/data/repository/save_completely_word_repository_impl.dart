import 'package:dartz/dartz.dart';
import '../../../shared/resources/strings.dart';
import '../datasource/save_completely_word_datasource.dart';
import 'package:words/dictionary/data/model/completely_word.dart';
import 'package:words/dictionary/domain/error/failure_dictionary.dart';
import 'package:words/dictionary/domain/repositories/save_completely_word_repository.dart';

class SaveCompletelyWordImpl implements ISaveCompletelyWordRepository {
  final ISaveCompleteWordDataSource dataSource;

  SaveCompletelyWordImpl(this.dataSource);

  @override
  Future<Either<FailureWord, bool>> saveCompletelyWord(
      CompletelyWord completelyWord) async {
    try {
      final result = await dataSource.saveCompletelyWord(completelyWord);
      return Right(result);
    } on SaveCompletelyWordDataSourceError catch (e) {
      return Future.value(Left(e));
    } catch (e) {
      return Future.value(
        Left(
          SaveCompletelyWordDataSourceError(
            message: Strings.saveWordError,
          ),
        ),
      );
    }
  }
}
