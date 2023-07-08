import 'package:dartz/dartz.dart';
import '../../../shared/resources/strings.dart';
import 'package:words/dictionary/data/model/word_completed.dart';
import 'package:words/dictionary/domain/error/failure_word.dart';
import 'package:words/dictionary/data/datasource/get_completely_word.dart';
import 'package:words/dictionary/domain/repositories/get_completely_word_repository.dart';

class GetCompletelyWordImpl implements IGetCompletelyWordRepository {
  final IDoGetCompletelyWordDataSource dataSource;

  GetCompletelyWordImpl(this.dataSource);

  @override
  Future<Either<FailureWord, WordCompleted>> getCompletelyWord(String? word) async {
    try{
      final result = await dataSource.doGetCompletelyWord(word);
      return Right(result);
    } on CompletelyWordDataSourceError catch (e){
      return Left(e);
    } catch (e){
      return Left(CompletelyWordDataSourceError(message:Strings.genericError));
    }
  }


}