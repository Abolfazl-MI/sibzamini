//  this class used for monitoring the request and just for debugng goal

import 'dart:developer';

import 'package:dio/dio.dart';

class ApiInterCeptor extends Interceptor{

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler)async {
    log('REQUEST [${options.method}]=> PATH: ${options.path}');
    return super.onRequest(options, handler);
  }
  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler)async {
    log('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    return super.onResponse(response, handler);
  }
  @override
  Future onError(DioError err, ErrorInterceptorHandler handler)async {
    log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    return super.onError(err, handler);
  }

}