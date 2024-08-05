part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}
class RequestEmailOtp extends AuthenticationEvent{
  final Map<String,String> UserEmail;
  RequestEmailOtp({required this.UserEmail});
}

class VerifyEmailOtp extends AuthenticationEvent{
  final Map<String,String> emailAndOtp;
  VerifyEmailOtp({required this.emailAndOtp});
}

class RequestMobileOtp extends AuthenticationEvent{
  final Map<String,String> mobileNumber;
  RequestMobileOtp({required this.mobileNumber});
}
class VerifyMobileOtp extends AuthenticationEvent{
  final Map<String,String> mobileAndOtp;
  VerifyMobileOtp({required this.mobileAndOtp});
}
class GoogleSignInClicked extends AuthenticationEvent{
  
}