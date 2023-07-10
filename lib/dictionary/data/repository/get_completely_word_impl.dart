import 'package:dartz/dartz.dart';
import '../../../shared/resources/strings.dart';
import 'package:words/dictionary/data/model/completely_word.dart';
import 'package:words/dictionary/domain/error/failure_word.dart';
import 'package:words/dictionary/domain/repositories/get_completely_word_repository.dart';

import '../../external/get_completely_word_external.dart';

class GetCompletelyWordImpl implements IGetCompletelyWordRepository {
  final DoGetCompletelyWordExternal dataSource;

  GetCompletelyWordImpl(this.dataSource);

  @override
  Future<Either<FailureWord, CompletelyWord>> getCompletelyWord(String? word) async {
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