import 'package:dartz/dartz.dart';
import '../../../shared/resources/strings.dart';
import '../../internal/get_completely_word_internal.dart';
import 'package:words/dictionary/domain/error/failure_word.dart';
import 'package:words/dictionary/data/model/completely_word.dart';
import 'package:words/dictionary/domain/repositories/get_completely_word_internal_repository.dart';

class GetCompletelyWordInternalImpl implements IGetCompletelyWordInternalRepository {
  final DoGetCompletelyWordInternal dataSource;

  GetCompletelyWordInternalImpl(this.dataSource);

  @override
  Future<Either<FailureWord, CompletelyWord>> getCompletelyWordInternal(String? word) async {
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