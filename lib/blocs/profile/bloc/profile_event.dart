part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}
class EditProfileClicked extends ProfileEvent{
  final File ?image;
  final String userName;
  EditProfileClicked({required this.image, required this.userName});
}

class GetProfileDetails extends ProfileEvent{}