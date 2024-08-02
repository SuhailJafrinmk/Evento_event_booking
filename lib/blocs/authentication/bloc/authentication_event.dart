part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}
class RequestEmailOtp extends AuthenticationEvent{
  final Map<String,String> UserEmail;
  RequestEmailOtp({required this.UserEmail});
}

class VerifyEmailOtp extends AuthenticationEvent{
  final Map<String,String> otp;
  VerifyEmailOtp({required this.otp});
}

class RequestMobileOtp extends AuthenticationEvent{
  final Map<String,String> mobileNumber;
  RequestMobileOtp({required this.mobileNumber});
}