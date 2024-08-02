part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}
class EmailOtpRequested extends AuthenticationState {}
class EmailOtpVerified extends AuthenticationState{}
class MobileNumberOtpVerified extends AuthenticationState{}
