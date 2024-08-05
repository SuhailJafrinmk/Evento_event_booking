import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:evento_event_booking/resources/api_urls/api_urls.dart';

class DioClient{
  DioClient._();
 static final DioClient dioClient=DioClient._();
 static DioClient get instance =>dioClient;
 late Dio dio;
 void initialize(){
  dio=Dio(
    BaseOptions(
      baseUrl: ApiUrls.baseUrl,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    )
  );
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        
      },
    )
  );
      // Bypass SSL Verification (for development purposes)
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      client.badCertificateCallback = (cert, host, port) => true;
      return client;
    };
 }
}