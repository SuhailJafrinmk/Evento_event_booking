import 'package:either_dart/either.dart';
import 'package:evento_event_booking/data/network/api_services.dart';
import 'package:evento_event_booking/utils/app_exceptions.dart';
import 'package:evento_event_booking/utils/identify_exception.dart';
import 'dart:developer' as developer;

//this class handles the authentication related api calls which is done in the ApiServices class 
//It returns an either of <Future<Either<Exception,dynamic>>> 
//the status codes inside the else case is handles within a switch-case
class UserAuthenticationRepo{
  //method for sending an otp request to the user provided email id
  static EitherResponse requestEmailOtp(Map<String,String> userEmail)async{
  try{
    final response=await ApiServices.instance.requestEmailOtp(userEmail);
    if(response.statusCode==201||response.statusCode==200){
      return Right(response);
    }else{
      return Left(mapStatusCodeToException(response.statusCode));
    }
  }catch(e){
    return Left(AppExceptions(errorMessage: e.toString()));
  }
  }
  
  //method for requesting an otp to the user provided phone number
  static EitherResponse requestMobileOtp(Map<String,String> userMobileNo)async{
    try{
    final response=await ApiServices.instance.requestMobileOtp(userMobileNo);
     developer.log('the status code for mobilenumber otp request is ${response.statusCode}');
    if(response.statusCode==201||response.statusCode==200){
      return Right(response);
    }else{
      return Left(mapStatusCodeToException(response.statusCode));
    }
  }catch(e){
    return Left(AppExceptions(errorMessage: e.toString()));
  }
  }

  //method for verifying the user with the provided email and otp
  static EitherResponse verifyEmailOtp(Map<String,String> mailAndOtp)async{
        try{
    final response=await ApiServices.instance.verifyEmailOtp(mailAndOtp);
    if(response.statusCode==201||response.statusCode==200){
      return Right(response);
    }else{
      return Left(mapStatusCodeToException(response.statusCode));
    }
  }catch(e){
    return Left(AppExceptions(errorMessage: e.toString()));
  }
  }

    static EitherResponse verifyMobileOtp(Map<String,String> mobileAndOtp)async{
        try{
    final response=await ApiServices.instance.verifyEmailOtp(mobileAndOtp);
    if(response.statusCode==201||response.statusCode==200){
      return Right(response);
    }else{
      return Left(mapStatusCodeToException(response.statusCode));
    }
  }catch(e){
    return Left(AppExceptions(errorMessage: e.toString()));
  }
  }


}
