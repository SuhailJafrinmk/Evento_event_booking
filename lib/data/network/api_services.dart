import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:evento_event_booking/data/network/dio_configure.dart';
import 'package:evento_event_booking/development_only/custom_logger.dart';
import 'package:evento_event_booking/resources/api_urls/api_urls.dart';
import 'package:evento_event_booking/utils/app_exceptions.dart';

typedef EitherResponse = Future<Either<AppExceptions, Response>>;

class ApiServices {
  ApiServices._();
  static final ApiServices _instance = ApiServices._();
  static ApiServices get instance => _instance;
  Future<Response> requestEmailOtp(Map<String, String> email) async {
    final response = await DioClient.instance.dio.post(
      ApiUrls.emailOtpRequest,
      data: jsonEncode(email),
    );
    return response;
  }

  Future<Response> verifyEmailOtp(Map<String, String> emailAndOtp) async {
    final response = await DioClient.instance.dio.post(
      ApiUrls.emailOtpVerification,
      data: jsonEncode(emailAndOtp),
    );
    return response;
  }

  Future<Response> requestMobileOtp(Map<String, String> mobile) async {
    final response = await DioClient.instance.dio.post(
      ApiUrls.phoneOtpRequest,
      data: jsonEncode(mobile),
    );
    return response;
  }

  Future<Response> verifyMobileOtp(Map<String, String> mobileAndOtp) async {
    final response = await DioClient.instance.dio.post(
      ApiUrls.phoneOtpVerification,
      data: jsonEncode(mobileAndOtp),
    );
    return response;
  }

  Future<Response> verifyGoogleAccount(Map<String, String> accessToken) async {
    final response = await DioClient.instance.dio.post(
      ApiUrls.googleAuthentication,
      data: jsonEncode(accessToken),
    );
    return response;
  }

  Future<Response> tokenRefresh(Map<String, String> refreshToken) async {
    final String url = "${ApiUrls.baseUrl}${ApiUrls.refreshToken}";
    final response = await DioClient.instance.dio.post(
      ApiUrls.refreshToken,
      data: jsonEncode(refreshToken),
    );
    return response;
  }

  Future<Response> getAllEvents() async {
    final response = await DioClient.instance.dio.get(
      ApiUrls.getEvents,
    );
    log('the raw data for all events is : $response');
    return response;
  }

  Future<Response> getLocations() async {
    final response = await DioClient.instance.dio.get(
      ApiUrls.getLocations,
    );
    return response;
  }

  Future<Response> getEventCategories() async {
    final response = await DioClient.instance.dio.get(
      ApiUrls.getEventCategories,
    );
    return response;
  }

  Future<Response> getTrendingEvents() async {
    final response = await DioClient.instance.dio.get(
      ApiUrls.getTrendingEvents,
    );
    return response;
  }

  Future<Response> getEventByLocation(int id) async {
    final response = await DioClient.instance.dio.get(
      ApiUrls.byLocation(id),
    );
    logInfo('the raw data for getevent by location is:$response');
    return response;
  }

  Future<Response> getEventDetails(int id) async {
    final response = await DioClient.instance.dio.get(ApiUrls.eventDetails(id));
    logInfo('the raw data for getevent details is:$response');
    return response;
  }

  Future<Response> getMoreEvents(String nextPageUrl) async {
    String endPoint = nextPageUrl.split('.ink').last;
    final response = await DioClient.instance.dio.get(endPoint);
    logInfo('the raw data for getevent details is:$response');
    return response;
  }

  Future<Response> addToFavourites(int id) async {
    final response = await DioClient.instance.dio.post(
      ApiUrls.addToWishlist(id),
    );
    logInfo('the response for adding to favourites is:$response');
    return response;
  }

  Future<Response> getAllFavourites() async {
    final response = await DioClient.instance.dio.get(
      ApiUrls.getWishlistedEvents
    );
    logInfo('the response for getting all favourites is:$response');
    return response;
  }

  Future<Response> deleteFromFavourites(int id) async {
    final response = await DioClient.instance.dio.delete(
      ApiUrls.removeFromWishlist(id),
    );
    logInfo('the response for getting all favourites is:$response');
    return response;
  }

  Future<Response> bookMyTicket(int id,int ticketCount)async{
    final Map<String,dynamic> queryParameters={'ticket_id':id};
    final Map<String,dynamic> data={"ticket_count":ticketCount};
    final response=await DioClient.instance.dio.post(
      "/events/ticket/booking/$id",
      // ApiUrls.bookATicket,
      // queryParameters: queryParameters,
      data: jsonEncode(data),
    );
    return response;
  }
}
