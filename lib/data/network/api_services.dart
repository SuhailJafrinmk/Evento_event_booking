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
      logInfo('');
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
      logInfo('the raw data from verifymobileaotp is ${response}');
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

        Future<Response> tokenRefresh(Map<String,String> refreshToken)async{
        logInfo('the access token is ${SharedPref.instance.getToken()} and refresh token is ${SharedPref.instance.getRefreshToken()}');
        logInfo('api is calling for refreshing token');
        final String url="${ApiUrls.baseUrl}${ApiUrls.refreshToken}";
        logInfo(url);
        final String requestData=jsonEncode(refreshToken);
        logInfo('the request data is $requestData');
        final response=await DioClient.instance.dio.post(
        ApiUrls.refreshToken,
        data: jsonEncode(refreshToken),
        );
        logInfo('api response for refreshing token is being completd');
        return response;
        }
       

  
        Future<Response> getAllEvents()async{
        final response=await DioClient.instance.dio.get(
        ApiUrls.getEvents,
        );
        logInfo('the raw data from getting all events api:${response.data}');
        return response;
        }


        Future<Response> getLocations()async{
        final response=await DioClient.instance.dio.get(
        ApiUrls.getLocations,
        );
        logInfo('raw data from getting event locations api:${response.data}');
        return response;
        }

        Future<Response> getEventCategories()async{
        final response=await DioClient.instance.dio.get(
        ApiUrls.getEventCategories,
        );
        logInfo('the raw data for eventcategories is:$response');
        return response;
        }       

        Future<Response> getTrendingEvents()async{
        final response=await DioClient.instance.dio.get(
        ApiUrls.getTrendingEvents,
        );
        logInfo('the raw data for trending events is:$response');
        return response;
        } 

        Future<Response> getEventDetails()async{
        final response=await DioClient.instance.dio.get(
        ApiUrls.getTrendingEvents,
        );
        logInfo('the raw data for trending events is:$response');
        return response;
        }          

}