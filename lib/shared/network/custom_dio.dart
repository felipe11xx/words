import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:words/shared/network/api_keys.dart';

class CustomDio extends DioForNative {
  CustomDio() {
    interceptors.add(CustomInterceptor());
  }

  addHeader(String key, String? value) {
    options.headers[key] = value;
  }

  removeHeader(String key) {
    options.headers.remove(key);
  }
}

class CustomInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("##### Log _onRequest CustomDio #### ${options.path}");

    options.headers['X-RapidAPI-Key'] = ApiKeys.rapidApikey;
    options.headers['X-RapidAPI-Host'] = 'wordsapiv1.p.rapidapi.com';

    super.onRequest(options, handler);
  }


  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("##### Log _onResponse CustomDio ####");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
        "##### Log _onError CustomDio #### ${err.message} URI: ${err.requestOptions.uri}");
    super.onError(err, handler);
  }


}

