part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}
final class AuthenticationInitial extends AuthenticationState {}

class RequestingEmailOtp extends AuthenticationState{}
class RequestingMobileOtp extends AuthenticationState{}
class RequestingGoogleToken extends AuthenticationState{}

class EmailOtpRequested extends AuthenticationState {}
class MobileOtpRequested extends AuthenticationState{}
class GoogleTokenRequested extends AuthenticationState{}

class VerifyingEmailOtp extends AuthenticationState{}
class VerfiyingMobileOtp extends AuthenticationState{}
class VerfiyingGoogleToken extends AuthenticationState{}

class EmailOtpVerified extends AuthenticationState{}
class MobileNumberOtpVerified extends AuthenticationState{}
class GoogleAuthenticationTokenVerified extends AuthenticationState{}

class ErrorSendingEmailOtp extends AuthenticationState{
  final String errorMessage;
  ErrorSendingEmailOtp({required this.errorMessage});
}
class ErrorSendingMobileOtp extends AuthenticationState{
  final String errorMessage;
  ErrorSendingMobileOtp({required this.errorMessage});
}
class ErrorGettingGoogleToken extends AuthenticationState{}

class EmailOtpNotVerified extends AuthenticationState{
  final String errorMessage;
  EmailOtpNotVerified({required this.errorMessage});
}
class MobileNumberOtpNotVerified extends AuthenticationState{
  final String errorMessage;
  MobileNumberOtpNotVerified({required this.errorMessage});
}
class GoogleTokenNOtVerified extends AuthenticationState{}
