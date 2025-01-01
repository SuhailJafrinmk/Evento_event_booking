import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:evento_event_booking/models/user_profile_model.dart';
import 'package:evento_event_booking/repositories/profile_repo.dart';
import 'package:meta/meta.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileDataLoading()) {
    on<EditProfileClicked>(editProfileClicked);
    on<GetProfileDetails>(getProfileDetails);
  }


  FutureOr<void> editProfileClicked(EditProfileClicked event, Emitter<ProfileState> emit)async{
    emit(UpdatingProfileData());
    MultipartFile imageFile=await MultipartFile.fromFile(event.image!.path,filename: event.image!.path);
    FormData formData=FormData.fromMap({
      'username':event.userName,
      'profile_picture':imageFile,
    });
    final response=await ProfileRepo.updateProfile(formData);
       response.fold(
      (failure) {
        emit(ErrorFetchingProfileData(errorMessage: failure.errorMessage));
      },
      (success) {
        emit(ProfileDataUpdated()); 
        add(GetProfileDetails());
      },
    );
  }
  

  FutureOr<void> getProfileDetails(GetProfileDetails event, Emitter<ProfileState> emit)async{
    final response=await ProfileRepo.GetProfileDetails();
    response.fold(
     (failure){
      emit(ErrorFetchingProfileData(errorMessage: failure.errorMessage));
     },
     (success){
      final data=success.data;
      final UserProfile userProfile=UserProfile.fromJson(data as Map<String,dynamic>);
      emit(ProfileDataFetched(userProfile: userProfile));
     });

  }
}
