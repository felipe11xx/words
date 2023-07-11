abstract class FailureDictionary implements Exception{}

class CompletelyWordDataSourceError implements FailureDictionary {

  final String? message;
  final bool is404;

  CompletelyWordDataSourceError({this.message, this.is404 = false});

}

class SaveCompletelyWordDataSourceError implements FailureDictionary {
  final String? message;

  SaveCompletelyWordDataSourceError({
    this.message,

  });
}