import 'dart:async';
import 'dart:developer' as developer;
import 'package:bloc/bloc.dart';
import 'package:evento_event_booking/data/shared_preferences/shared_preferences.dart';
import 'package:evento_event_booking/repositories/authentication_repo.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

/// Bloc responsible for handling authentication-related events and states.
class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  /// Initializes the AuthenticationBloc with an initial state.
  /// Registers event handlers for various authentication events.
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<RequestEmailOtp>(requestEmailOtp);
    on<VerifyEmailOtp>(verifyEmailOtp);
    on<RequestMobileOtp>(requestMobileOtp);
    on<VerifyMobileOtp>(verifyMobileOtp);
    on<GoogleSignInClicked>(googleSignInClicked);
  }

  /// Handles the RequestEmailOtp event by requesting an OTP to be sent to the provided email.
  /// 
  /// [event] The RequestEmailOtp event containing the user email.
  /// [emit] The function to emit new states.
  FutureOr<void> requestEmailOtp(RequestEmailOtp event, Emitter<AuthenticationState> emit) async {
    developer.log('in requestEmailOtp method');
    emit(RequestingEmailOtp());
    final result = await UserAuthenticationRepo.requestEmailOtp(event.UserEmail);
    developer.log('the result is ');
    emit(result.fold(
      (exception) => ErrorSendingEmailOtp(errorMessage: exception.errorMessage),
      (right) => EmailOtpRequested(),
    ));
  }

  /// Handles the VerifyEmailOtp event by verifying the provided email and OTP.
  /// 
  /// [event] The VerifyEmailOtp event containing the email and OTP.
  /// [emit] The function to emit new states.
  FutureOr<void> verifyEmailOtp(VerifyEmailOtp event, Emitter<AuthenticationState> emit) async {
    emit(VerifyingEmailOtp());
    final response = await UserAuthenticationRepo.verifyEmailOtp(event.emailAndOtp);
    if (response.isRight) {
      final result = response.right.data;
      if (result.containsKey('access_token')) {
        final String token = result['access_token'];
        SharedPref.instance.storeToken(token);
        developer.log('Token stored in shared pref');
      }
      emit(EmailOtpVerified());
    } else {
      emit(EmailOtpNotVerified(errorMessage: response.left.errorMessage));
    }
  }

  /// Handles the RequestMobileOtp event by requesting an OTP to be sent to the provided mobile number.
  /// 
  /// [event] The RequestMobileOtp event containing the mobile number.
  /// [emit] The function to emit new states.
  FutureOr<void> requestMobileOtp(RequestMobileOtp event, Emitter<AuthenticationState> emit) async {
    emit(RequestingMobileOtp());
    final result = await UserAuthenticationRepo.requestMobileOtp(event.mobileNumber);
    emit(result.fold(
      (exception) => MobileNumberOtpNotVerified(errorMessage: exception.errorMessage),
      (right) => MobileNumberOtpVerified(),
    ));
  }

  /// Handles the VerifyMobileOtp event by verifying the provided mobile number and OTP.
  /// 
  /// [event] The VerifyMobileOtp event containing the mobile number and OTP.
  /// [emit] The function to emit new states.
  FutureOr<void> verifyMobileOtp(VerifyMobileOtp event, Emitter<AuthenticationState> emit) {
    // Implementation for verifying mobile OTP
  }

  /// Handles the GoogleSignInClicked event by signing in with Google.
  /// 
  /// [event] The GoogleSignInClicked event.
  /// [emit] The function to emit new states.
  FutureOr<void> googleSignInClicked(GoogleSignInClicked event, Emitter<AuthenticationState> emit) async {
    emit(RequestingGoogleToken());
    final result = await UserAuthenticationRepo.googleAuthentication();
    if (result.isLeft) {
      emit(ErrorGettingGoogleToken());
    } else {
      emit(GoogleAuthenticationTokenVerified());
    }
  }
}
