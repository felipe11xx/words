abstract class FailureWord implements Exception{}


class CompletelyWordDataSourceError implements FailureWord {

  final String? message;
  final bool is404;

  CompletelyWordDataSourceError({this.message, this.is404 = false});

}

class SaveCompletelyWordDataSourceError implements FailureWord {
  final String? message;

  SaveCompletelyWordDataSourceError({
    this.message,

  });
}