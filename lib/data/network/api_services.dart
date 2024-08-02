import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:evento_event_booking/data/network/dio_configure.dart';
import 'package:evento_event_booking/resources/api_urls/api_urls.dart';

class ApiServices{
  ApiServices._();
  static final ApiServices _instance=ApiServices._();
  static ApiServices get instance => _instance;
  Future<Response> requestEmailOtp(Map<String,String> email)async{
    try{
      print(jsonEncode(email));
      final response=await DioClient.instance.dio.post(
        ApiUrls.emailOtpRequest,
        data: jsonEncode(email),
      );
      return response;
    }catch(e){
      print(e.toString());
      log('some error occured');
      throw e;
    }
  }

  Future<Response> verifyEmailOtp(Map<String,String> otp)async{
    try{
      final response=await DioClient.instance.dio.post(
        ApiUrls.emailOtpVerification,
        data: jsonEncode(otp),
      );
      return response;
    }catch(e){
      print(e.toString());
      throw e;
    }
  }
  
  Future<Response> requestMobileOtp(Map<String,String> mobile)async{
    try{
      final response=await DioClient.instance.dio.post(
        ApiUrls.phoneOtpRequest,
        data: jsonEncode(mobile),
      );
      return response;
    }catch(e){
      print(e.toString());
      throw e;
    }
  }
}