//  this class used for monitoring the request and just for debugng goal

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
class ApiInterCeptor extends Interceptor{
  final Logger _logger=Logger(
    printer: PrettyPrinter()
  );
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
    _logger.e('ERROR MESSAGE: ${err.message}');
    return super.onError(err, handler);
  }

}