import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

const baseUrl = 'https://demoteknologi.com/lakumobil.api/public/';

const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

class DioClient {
  final Dio _dio;
  final List<Interceptor>? interceptors;

  DioClient(
    this._dio, {
    this.interceptors,
  }) {
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = _defaultConnectTimeout
      ..options.receiveTimeout = _defaultReceiveTimeout
      ..httpClientAdapter
      ..options.headers = {
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.acceptHeader: 'application/json',
      };

    if (interceptors?.isNotEmpty ?? false) {
      interceptors?.forEach((element) {
        _dio.interceptors.add(element);
      });
    }

    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: false,
          requestBody: false));
    }
  }

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException('Unable to process the data');
    } catch (e) {
      print(
        '''
        ===============
        endpoint: $uri
        response: $e
        ===============
        ''',
      );
      throw e;
    }
  }

  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {
      throw FormatException('Unable to process the data');
    } catch (e) {
      print(
        '''
        ===============
        endpoint: $uri
        response: $e
        ===============
        ''',
      );
      throw e;
    }
  }
}
