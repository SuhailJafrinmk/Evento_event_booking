import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:evento_event_booking/data/network/api_services.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
   on<RequestEmailOtp>(requestEmailOtp);
   on<VerifyEmailOtp>(verifyEmailOtp);
   on<RequestMobileOtp>(requestMobileOtp);
  }

  FutureOr<void> requestEmailOtp(RequestEmailOtp event, Emitter<AuthenticationState> emit)async{
    final response=await ApiServices.instance.requestEmailOtp(event.UserEmail);
    emit(EmailOtpRequested());
  }


  FutureOr<void> verifyEmailOtp(VerifyEmailOtp event, Emitter<AuthenticationState> emit)async{
    final response=await ApiServices.instance.verifyEmailOtp(event.otp);
    emit(EmailOtpVerified());
  }

  FutureOr<void> requestMobileOtp(RequestMobileOtp event, Emitter<AuthenticationState> emit)async{
    final response=await ApiServices.instance.requestMobileOtp(event.mobileNumber);
    emit(MobileNumberOtpVerified());
  }
}
