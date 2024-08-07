import 'dart:convert';
import 'dart:developer';
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:evento_event_booking/data/network/dio_configure.dart';
import 'package:evento_event_booking/resources/api_urls/api_urls.dart';
import 'package:evento_event_booking/utils/app_exceptions.dart';


typedef EitherResponse=Future<Either<AppExceptions,Response>>;
class ApiServices{
  ApiServices._();
  static final ApiServices _instance=ApiServices._();
  static ApiServices get instance => _instance;
    Future<Response> requestEmailOtp(Map<String,String> email)async{
      final  response=await DioClient.instance.dio.post(
        ApiUrls.emailOtpRequest,
        data: jsonEncode(email),
      );
      return response;
      }

    Future<Response> verifyEmailOtp(Map<String,String> emailAndOtp)async{
      final response=await DioClient.instance.dio.post(
        ApiUrls.emailOtpVerification,
        data: jsonEncode(emailAndOtp),
      );
      return response;
      }
  
    Future<Response> requestMobileOtp(Map<String,String> mobile)async{
      final response=await DioClient.instance.dio.post(
        ApiUrls.phoneOtpRequest,
        data: jsonEncode(mobile),
      );
      return response;
      }

    Future<Response> verifyMobileOtp(Map<String,String> mobileAndOtp)async{
      final response=await DioClient.instance.dio.post(
        ApiUrls.phoneOtpVerification,
        data: jsonEncode(mobileAndOtp),
      );
      return response;
      }

      Future<Response> verifyGoogleAccount(Map<String,String> accessToken)async{
      developer.log('logging the map inside the api service class ${jsonEncode(accessToken)}');
      final response=await DioClient.instance.dio.post(
        ApiUrls.googleAuthentication,
        data: jsonEncode(accessToken),
      );
      return response;
      }

      Future<Response> tokenRefresh(Map<String,String> accessToken)async{
      developer.log('logging the map inside the api service class ${jsonEncode(accessToken)}');
      final response=await DioClient.instance.dio.post(
        ApiUrls.googleAuthentication,
        data: jsonEncode(accessToken),
      );
      return response;
      }


}