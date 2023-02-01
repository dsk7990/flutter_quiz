import 'dart:io';
import 'dart:async';

import 'package:dio/dio.dart';

import 'custom_exceprion.dart';

class ApiProvider {
  final _headers = {'Content-Type': 'application/json'};

  /// get
  Future<dynamic> get(String url,
      {String path = '',
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers}) async {
    final dio = Dio(
      BaseOptions(
        connectTimeout: 30000,
        receiveTimeout: 30000,
        baseUrl: url,
      ),
    );
    var responseJson;
    try {
      dio.options.headers = headers ?? _headers;
      final response =
          await dio.get<dynamic>(path, queryParameters: queryParameters);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException(''); //No Internet connection
    }
    return responseJson;
  }

  /// post
  Future<dynamic> post(
    String url, {
    String path = '',
    Map<String, String>? headers,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final dio = Dio(
      BaseOptions(
        connectTimeout: 30000,
        receiveTimeout: 30000,
        baseUrl: url,
      ),
    );
    var responseJson;
    try {
      dio.options.headers = headers ?? _headers;
      final response = await dio.post<dynamic>(path,
          data: data, queryParameters: queryParameters);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException(''); //No Internet connection
    }
    return responseJson;
  }

  dynamic _response(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.data;
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.data.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
