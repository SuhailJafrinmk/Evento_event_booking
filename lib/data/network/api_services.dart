import 'dart:convert';
import 'dart:developer';
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:evento_event_booking/data/network/dio_configure.dart';
import 'package:evento_event_booking/data/shared_preferences/shared_preferences.dart';
import 'package:evento_event_booking/development_only/custom_logger.dart';
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

        Future<Response> tokenRefresh(Map<String, String> refreshToken) async {
    logInfo('The access token is ${SharedPref.instance.getToken()} and refresh token is ${SharedPref.instance.getRefreshToken()}');
    logInfo('API is calling for refreshing token');

    try {
      final String url = "${ApiUrls.baseUrl}${ApiUrls.refreshToken}";
      logInfo('URL: $url');
      
      final String requestData = jsonEncode(refreshToken);
      logInfo('The request data is $requestData');

      final response = await DioClient.instance.dio.post(
        url,
        data: requestData,
      );

      logInfo('API response for refreshing token is completed');
      return response;
    } catch (e) {
      if (e is DioError) {
        logError('Error refreshing token: ${e.response?.statusCode} ${e.response?.data}');
      } else {
        logError('Unexpected error refreshing token: $e');
      }
      rethrow;
    }
  }

      // Future<Response> tokenRefresh(Map<String,String> refreshToken)async{
      //   logInfo('the access token is ${SharedPref.instance.getToken()} and refresh token is ${SharedPref.instance.getRefreshToken()}');
      //   logInfo('api is calling for refreshing token');
      //   final String url="${ApiUrls.baseUrl}${ApiUrls.refreshToken}";
      //   logInfo(url);
      //   final String requestData=jsonEncode(refreshToken);
      //   logInfo('the request data is $requestData');
      // final response=await DioClient.instance.dio.post(
      //   ApiUrls.googleAuthentication,
      //   data: jsonEncode(refreshToken),
      // );
       
      // logInfo('api response for refreshing token is being completd');
      // return response;
      // }
       

       //to delete
      // Future<Response> getEvents()async{
      // final response=await DioClient.instance.dio.get(
      //   ApiUrls.getEvents,
      // );
      // logInfo('${response.data}');
      // return response;
      // }
  Future<Response> getEvents() async {
    try {
      logInfo('Fetching events from API...');
      final response = await DioClient.instance.dio.get(
        ApiUrls.getEvents,
      );
      logInfo('Events fetched successfully: ${response.data}');
      return response;
    } catch (e) {
      if (e is DioError) {
        logError('Error fetching events: ${e.response?.statusCode} ${e.response?.data}');
      } else {
        logError('Unexpected error fetching events: $e');
      }
      rethrow;
    }
  }

}