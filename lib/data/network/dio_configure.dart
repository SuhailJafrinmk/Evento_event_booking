import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:evento_event_booking/data/network/api_services.dart';
import 'package:evento_event_booking/data/shared_preferences/shared_preferences.dart';
import 'package:evento_event_booking/development_only/custom_logger.dart';
import 'package:evento_event_booking/resources/api_urls/api_urls.dart';

class DioClient {
  DioClient._();
  static final DioClient dioClient = DioClient._();
  static DioClient get instance => dioClient;
  late Dio dio;
  void initialize() {
    dio = Dio(BaseOptions(
      baseUrl: ApiUrls.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        String? accessToken = SharedPref.instance.getToken();
        if (accessToken != null) {
          logInfo('authorisatin token added to request header');
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          logError('request failed with status code 401 user not authorised');
          bool success = await refreshToken();
          if (success) {
            return handler.resolve(await _retryRequest(error.requestOptions));
          }
        }
        return handler.next(error);
      },
    ));

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (cert, host, port) => true;
      return client;
    };
  }

  Future<Response> _retryRequest(RequestOptions requestOptions) async {
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
    logInfo('token is getting refreshed');
    try {
      final String? refreshToken = SharedPref.instance.getRefreshToken();
      if (refreshToken == null) {
        throw Exception("No refresh token found");
      }
      final response =
          await ApiServices.instance.tokenRefresh({"refresh": refreshToken});
      if (response.statusCode == 200) {
        final String newAccessToken = response.data['access'];
        final String newRefreshToken = response.data['refresh'];
        SharedPref.instance.storeTokens(newAccessToken, newRefreshToken);
        return true;
      } else {
        throw Exception("Failed to refresh token");
      }
    } catch (e) {
      print("Error refreshing token: $e");
      return false;
    }
  }
}
