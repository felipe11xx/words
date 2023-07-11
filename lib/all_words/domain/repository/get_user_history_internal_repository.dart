abstract class IGetCompletelyWordRepository {
  Future<Either<FailureWord,CompletelyWord>>getCompletelyWord(String? word);
}