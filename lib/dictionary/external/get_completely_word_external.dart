import 'package:dio/dio.dart';
import '../domain/error/error_body.dart';
import '../../shared/resources/strings.dart';
import '../../shared/network/custom_dio.dart';
import 'package:words/shared/network/urls.dart';
import '../domain/error/failure_dictionary.dart';
import 'package:words/dictionary/data/model/completely_word.dart';
import 'package:words/dictionary/data/datasource/get_completely_word_datasource.dart';

class DoGetCompletelyWordExternalDatasource implements IDoGetCompletelyWordDataSource {
  final CustomDio customDio;

  DoGetCompletelyWordExternalDatasource(this.customDio);

  @override
  Future<CompletelyWord> doGetCompletelyWord(String? word) async {
    try {
      final response = await customDio.get(
        '${Urls.wordsApiGet}$word',
      );

      if (response.statusCode == 200) {
        return CompletelyWord.fromJson(response.data);
      } else {
        throw CompletelyWordDataSourceError(
          message: response.statusMessage,
        );
      }
    } on DioException catch (e) {
      var error = ErrorBody.fromMap(e.response?.data);
      throw CompletelyWordDataSourceError(
        message: error.message,
        is404: (e.response?.statusCode == 404)
      );
    } catch (e) {
      throw CompletelyWordDataSourceError(
        message: Strings.genericError,
      );
    }
  }
}
