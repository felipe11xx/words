import 'package:dio/dio.dart';
import 'package:words/dicionary/data/datasource/get_completely_word.dart';
import 'package:words/dicionary/data/model/word_completed.dart';
import 'package:words/shared/network/urls.dart';

import '../../shared/network/custom_dio.dart';
import '../../shared/resources/strings.dart';
import '../domain/error/error_body.dart';
import '../domain/error/failure_word.dart';

class DoGetCompletelyWordExternal implements IDoGetCompletelyWordDataSource {
  final CustomDio customDio;

  DoGetCompletelyWordExternal(this.customDio);

  @override
  Future<WordCompleted> doGetCompletelyWord(String? word) async {
    try {
      // final response = await customDio.get(
      //   '${Urls.wordsApiGet}$word',
        final response = await customDio.get(
        '${Urls.wordsApiGet}light',
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw CompletelyWordDataSourceError(
          message: response.statusMessage,
        );
      }
    } on DioError catch (e) {
      var error = ErrorBody.fromMap(e.response?.data);
      throw CompletelyWordDataSourceError(
        message: error.message,
      );
    } catch (e) {
      throw CompletelyWordDataSourceError(
        message: Strings.genericError,
      );
    }
  }
}
