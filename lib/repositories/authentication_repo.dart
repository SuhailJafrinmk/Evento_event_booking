import 'package:either_dart/either.dart';
import 'package:evento_event_booking/data/network/api_services.dart';
import 'package:evento_event_booking/utils/app_exceptions.dart';
import 'package:evento_event_booking/utils/identify_exception.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:google_sign_in/google_sign_in.dart';

/// This class handles the authentication-related API calls which are done in the ApiServices class.
/// It returns an Either<Exception, dynamic>.
class UserAuthenticationRepo {

  /// Sends an OTP request to the provided email ID.
  /// 
  /// [userEmail] is a map containing the user's email.
  /// Returns an Either of the response or an exception.
  static EitherResponse requestEmailOtp(Map<String, String> userEmail) async {
    try {
      final response = await ApiServices.instance.requestEmailOtp(userEmail);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return Right(response);
      } else {
        return Left(mapStatusCodeToException(response.statusCode));
      }
    } catch (e) {
      return Left(AppExceptions(errorMessage: e.toString()));
    }
  }

  /// Requests an OTP to be sent to the provided phone number.
  /// 
  /// [userMobileNo] is a map containing the user's mobile number.
  /// Returns an Either of the response or an exception.
  static EitherResponse requestMobileOtp(Map<String, String> userMobileNo) async {
    try {
      final response = await ApiServices.instance.requestMobileOtp(userMobileNo);
      developer.log('The status code for mobile number OTP request is ${response.statusCode}');
      if (response.statusCode == 201 || response.statusCode == 200) {
        return Right(response);
      } else {
        return Left(mapStatusCodeToException(response.statusCode));
      }
    } catch (e) {
      return Left(AppExceptions(errorMessage: e.toString()));
    }
  }

  /// Verifies the user with the provided email and OTP.
  /// 
  /// [mailAndOtp] is a map containing the email and OTP.
  /// Returns an Either of the response or an exception.
  static EitherResponse verifyEmailOtp(Map<String, String> mailAndOtp) async {
    try {
      final response = await ApiServices.instance.verifyEmailOtp(mailAndOtp);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return Right(response);
      } else {
        return Left(mapStatusCodeToException(response.statusCode));
      }
    } catch (e) {
      return Left(AppExceptions(errorMessage: e.toString()));
    }
  }

  /// Verifies the user with the OTP sent to their mobile number.
  /// 
  /// [mobileAndOtp] is a map containing the mobile number and OTP.
  /// Returns an Either of the response or an exception.
  static EitherResponse verifyMobileOtp(Map<String, String> mobileAndOtp) async {
    try {
      final response = await ApiServices.instance.verifyMobileOtp(mobileAndOtp);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return Right(response);
      } else {
        return Left(mapStatusCodeToException(response.statusCode));
      }
    } catch (e) {
      return Left(AppExceptions(errorMessage: e.toString()));
    }
  }

  /// Signs in the user using their Google account credentials.
  /// 
  /// Returns an Either of the GoogleSignInAccount or an exception.
  static Future<Either<Exception, GoogleSignInAccount>> googleAuthentication() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
      'email', // Request access to the user's email address
      'profile', // Request access to the user's profile information
    ]);
    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        return Right(account);
      } else {
        return Left(Exception('Google sign-in cancelled or failed'));
      }
    } catch (e) {
      return Left(Exception('Google sign-in error: $e'));
    }
  }
}
