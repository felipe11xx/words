abstract class FailureWord implements Exception{}


class CompletelyWordDataSourceError implements FailureWord {

  final String? message;

  CompletelyWordDataSourceError({this.message});
}