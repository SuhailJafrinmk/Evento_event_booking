// import 'package:dio/dio.dart';
// import 'package:dio/io.dart';
// import 'package:evento_event_booking/data/network/api_services.dart';
// import 'package:evento_event_booking/data/shared_preferences/shared_preferences.dart';
// import 'package:evento_event_booking/development_only/custom_logger.dart';
// import 'package:evento_event_booking/resources/api_urls/api_urls.dart';

// class DioClient {
//   DioClient._();
//   static final DioClient dioClient = DioClient._();
//   static DioClient get instance => dioClient;
//   late Dio dio;
//   void initialize() {
//     dio = Dio(BaseOptions(
//       baseUrl: ApiUrls.baseUrl,
//       connectTimeout: const Duration(seconds: 15),
//       receiveTimeout: const Duration(seconds: 15),
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//       },
//     ));
//     dio.interceptors.add(InterceptorsWrapper(
//       onRequest: (options, handler) {
//         String? accessToken =  SharedPref.instance.getToken();
//         if (accessToken != null) {
//           logInfo('authorisatin token added to request header');
//           options.headers['Authorization'] = 'Bearer $accessToken';
//         }
//         return handler.next(options);
//       },
//       onResponse: (response, handler) {
//         return handler.next(response);
//       },
//       onError: (error, handler) async {
//         if (error.response?.statusCode == 401) {
//           logError('request failed with status code 401 user not authorised token need to be refreshed');
//           bool success = await refreshToken();
//           if (success) {
//             logInfo('token successully refreshed');
//             return handler.resolve(await _retryRequest(error.requestOptions));
//           }
//         }
//         return handler.next(error);
//       },
//     ));

//     (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//         (client) {
//       client.badCertificateCallback = (cert, host, port) => true;
//       return client;
//     };
//   }

//   Future<Response> _retryRequest(RequestOptions requestOptions) async {
//     logInfo('requesting for a new token.........');
//     final options = Options(
//       method: requestOptions.method,
//       headers: requestOptions.headers,
//     );
//     return dio.request(
//       requestOptions.path,
//       options: options,
//       data: requestOptions.data,
//       queryParameters: requestOptions.queryParameters,
//     );
//   }

//   Future<bool> refreshToken() async {
//     logInfo('token is getting refreshed');
//     try {
//       final String? refreshToken = SharedPref.instance.getRefreshToken();
//       logInfo('refresh token is $refreshToken');
//       if (refreshToken == null) {
//         logError('no refresh token found in shared pref');
//         throw Exception("No refresh token found");
//       }
//       final response =
//           await ApiServices.instance.tokenRefresh({"refresh": refreshToken});
//           logInfo('response for refreshing token from api is ${response.data}');
//       if (response.statusCode == 200) {
//         final String newAccessToken = response.data['access'];
//         final String newRefreshToken = response.data['refresh'];
//         SharedPref.instance.storeTokens(newAccessToken, newRefreshToken);
//         logInfo('new tokens have been stored to sharedpref');
//         return true;
//       } else {
//         logError('failed to refresh the token');
//         throw Exception("Failed to refresh token");
//       }
//     } catch (e) {
//       print("Error refreshing token: $e");
//       return false;
//     }
//   }
// }
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:evento_event_booking/data/network/api_services.dart';
import 'package:evento_event_booking/data/shared_preferences/shared_preferences.dart';
import 'package:evento_event_booking/development_only/custom_logger.dart';
import 'package:evento_event_booking/resources/api_urls/api_urls.dart';
import 'package:flutter/foundation.dart'; 

class DioClient {
  DioClient._();
  static final DioClient dioClient = DioClient._();
  static DioClient get instance => dioClient;
  late Dio dio;
  
  void initialize() {
    dio = Dio(BaseOptions(
      baseUrl: ApiUrls.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    dio.interceptors.add(
      InterceptorsWrapper(
      onRequest: (options, handler) {
        String? accessToken = SharedPref.instance.getToken();
        if (accessToken != null) {
          logInfo('Authorization token added to request header');
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
           // Log request details
      logInfo('Making request: ${options.method} ${options.baseUrl}${options.path}');
      logInfo('Request Headers: ${options.headers}');
      if (options.queryParameters.isNotEmpty) {
        logInfo('Query Parameters: ${options.queryParameters}');
      }
      if (options.data != null) {
        logInfo('Request Body: ${options.data}');
      }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          logError('Request failed with status code 401, token needs to be refreshed');
          bool success = await refreshToken();
          if (success) {
            logInfo('Token successfully refreshed');
            return handler.resolve(await _retryRequest(error.requestOptions));
          } else {
            logError('Failed to refresh token, session expired');
            _handleSessionExpired();  
            return handler.reject(error);  
          }
        }
        return handler.next(error);
      },
    ));

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      if (!kReleaseMode) { 
        client.badCertificateCallback = (cert, host, port) => true;
      }
      return client;
    };
  }

  Future<Response> _retryRequest(RequestOptions requestOptions) async {
    logInfo('Retrying the request with a new token...');
    

    String? newAccessToken = SharedPref.instance.getToken();
    if (newAccessToken != null && newAccessToken.isNotEmpty) {
      requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
    }

    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request(
      requestOptions.path,
      options: options,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
    );
  }

  Future<bool> refreshToken() async {
    logInfo('Refreshing token...');
    try {
      final String? refreshToken = SharedPref.instance.getRefreshToken();
      logInfo('Refresh token: $refreshToken');
      if (refreshToken == null) {
        logError('No refresh token found in shared preferences');
        _handleSessionExpired(); 
        return false;
      }

      final response = await ApiServices.instance.tokenRefresh({"refresh": refreshToken});
      logInfo('Response for refreshing token from API: ${response.data}');
      
      if (response.statusCode == 200) {
        final String newAccessToken = response.data['access'];
        final String newRefreshToken = response.data['refresh'];

        if (newAccessToken != null && newAccessToken.isNotEmpty) {
          SharedPref.instance.storeAccessToken(newAccessToken);
        }

        if (newRefreshToken != null && newRefreshToken != SharedPref.instance.getRefreshToken()) {
          SharedPref.instance.storeRefreshToken(newRefreshToken);
        }

        logInfo('New tokens have been stored in shared preferences');
        return true;
      } else {
        logError('Failed to refresh the token, session needs to be renewed');
        _handleSessionExpired();
        return false;
      }
    } catch (e) {
      logError("Error refreshing token: $e");
      _handleSessionExpired();
      return false;
    }
  }


  void _handleSessionExpired() {
    logInfo('Session expired, clearing tokens');
    SharedPref.instance.removeToken(); 
  }
}
