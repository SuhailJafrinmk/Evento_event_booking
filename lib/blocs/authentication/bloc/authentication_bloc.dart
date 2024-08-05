import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:developer' as developer;
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:evento_event_booking/data/network/api_services.dart';
import 'package:evento_event_booking/data/shared_preferences/shared_preferences.dart';
import 'package:evento_event_booking/repositories/authentication_repo.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
   on<RequestEmailOtp>(requestEmailOtp);
   on<VerifyEmailOtp>(verifyEmailOtp);
   on<RequestMobileOtp>(requestMobileOtp);
   on<VerifyMobileOtp>(verifyMobileOtp);
  }

  FutureOr<void> requestEmailOtp(RequestEmailOtp event, Emitter<AuthenticationState> emit)async{
    emit(RequestingEmailOtp());
    final result=await UserAuthenticationRepo.requestEmailOtp(event.UserEmail);
    emit(result.fold((exception) => ErrorSendingEmailOtp(errorMessage: exception.errorMessage),
     (right) => EmailOtpRequested()));
  }


  FutureOr<void> verifyEmailOtp(VerifyEmailOtp event, Emitter<AuthenticationState> emit)async{
    emit(VerifyingEmailOtp());
    final response=await UserAuthenticationRepo.verifyEmailOtp(event.emailAndOtp);
    if (response.isRight) {
      final result = response.right.data;
      if (result.containsKey('access_token')) {
        final String token = result['access_token'];
         SharedPref.instance.storeToken(token);
         developer.log('Token stored in shared pref');
      }
      emit(EmailOtpVerified());
    }else{
      emit(EmailOtpNotVerified(errorMessage: response.left.errorMessage));
    }
  }

  FutureOr<void> requestMobileOtp(RequestMobileOtp event, Emitter<AuthenticationState> emit)async{
    emit(RequestingMobileOtp());
    final result=await UserAuthenticationRepo.requestMobileOtp(event.mobileNumber);
    emit(result.fold((exception) => MobileNumberOtpNotVerified(errorMessage: exception.errorMessage), (right) => MobileNumberOtpVerified()));
  }

  FutureOr<void> verifyMobileOtp(VerifyMobileOtp event, Emitter<AuthenticationState> emit) {
    
  }
}
