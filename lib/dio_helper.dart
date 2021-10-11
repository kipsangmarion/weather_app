import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_paths.dart';

late DioCacheManager _dioCacheManager;
Dio createDio() {
  _dioCacheManager = DioCacheManager(CacheConfig(
      baseUrl: ApiPaths.baseURL,
      defaultMaxAge: Duration(days: 7),
      defaultRequestMethod: "POST",
      databaseName: "mrion_cache"));

  Dio dio = Dio(BaseOptions(
    connectTimeout: 70000,
    receiveTimeout: 70000,
    baseUrl: ApiPaths.baseURL,
  ));
  dio.interceptors.add(
    PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90),
  );
  dio.interceptors.add(DioCacheManager(CacheConfig(
          baseUrl: ApiPaths.baseURL,
          defaultMaxAge: Duration(days: 7),
          defaultRequestMethod: "POST",
          databaseName: "mrion"))
      .interceptor);
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) {
      final isValidHost = host == ApiPaths.baseURL;
      return isValidHost;
    };
    dio.interceptors.add(_dioCacheManager.interceptor);

    return client;
  };
  return dio;
}

/// dio netwok handler
/// 1. handles all api calls
/// 2. cache data offline
/// 3. [dioHelper] .post .get .put etc
/// 4. [PrettyDioLogger] for logging request
final dioHelper = createDio();
