part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

class ProfileDataLoading extends ProfileState{}
class ProfileDataFetched extends ProfileState{
  final UserProfile userProfile;
  ProfileDataFetched({required this.userProfile});
}
class ErrorFetchingProfileData extends ProfileState{
  final String errorMessage;
  ErrorFetchingProfileData({required this.errorMessage});
}