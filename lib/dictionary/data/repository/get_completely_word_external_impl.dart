import 'package:dartz/dartz.dart';
import '../../../shared/resources/strings.dart';
import '../datasource/get_completely_word_datasource.dart';
import 'package:words/dictionary/data/model/completely_word.dart';
import 'package:words/dictionary/domain/error/failure_dictionary.dart';
import 'package:words/dictionary/domain/repositories/get_completely_word_repository.dart';

class GetCompletelyWordExternalImpl implements IGetCompletelyWordRepository {
  final IDoGetCompletelyWordDataSource dataSource;

  GetCompletelyWordExternalImpl(this.dataSource);

  @override
  Future<Either<FailureDictionary, CompletelyWord>> getCompletelyWord(String? word) async {
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