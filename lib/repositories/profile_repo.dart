import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:evento_event_booking/blocs/profile/bloc/profile_bloc.dart';
import 'package:evento_event_booking/data/network/api_services.dart';
import 'package:evento_event_booking/development_only/custom_logger.dart';
import 'package:evento_event_booking/utils/app_exceptions.dart';
import 'package:evento_event_booking/utils/identify_exception.dart';

class ProfileRepo {
  static EitherResponse updateProfile(FormData formdata)async{
   try {
      final response=await ApiServices.instance.updateProfile(formdata);
    if(response.statusCode==201){
      return Right(response);
    }
    AppExceptions exceptions=mapStatusCodeToException(response.statusCode);
    return Left(exceptions);
   } catch (e) {
    logError('some error occured while updating profile ${e.toString()}');
    return Left(AppExceptions(errorMessage: e.toString()));
   }
  }

  static EitherResponse GetProfileDetails()async{
   try {
      final response=await ApiServices.instance.getProfileDetails();
    if(response.statusCode==200){
      return Right(response);
    }
    AppExceptions exceptions=mapStatusCodeToException(response.statusCode);
    return Left(exceptions);
   } catch (e) {
    logError('some error occured while updating profile ${e.toString()}');
    return Left(AppExceptions(errorMessage: e.toString()));
   }
  }
}