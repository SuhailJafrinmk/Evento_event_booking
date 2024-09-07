import 'package:either_dart/either.dart';
import 'package:evento_event_booking/data/network/api_services.dart';
import 'package:evento_event_booking/development_only/custom_logger.dart';
import 'package:evento_event_booking/utils/app_exceptions.dart';
import 'package:evento_event_booking/utils/identify_exception.dart';

class EventsRepo{
   static EitherResponse getEventLocations() async {
    try {
      final response = await ApiServices.instance.getLocations();
      if (response.statusCode == 200) {
        return Right(response);
      } 
        AppExceptions appExceptions= mapStatusCodeToException(response.statusCode);
        return Left(appExceptions);
    } catch (e) {
      logError('the status code of getting event locations is ${e.toString()}');
      return Left(AppExceptions(errorMessage: e.toString()));
    }
  }

  static EitherResponse getEventCategories()async{
    try{
      final response=await ApiServices.instance.getEventCategories();
      if(response.statusCode==200){
        return Right(response);
      }
      AppExceptions appExceptions=mapStatusCodeToException(response.statusCode);
      return Left(appExceptions);
    }catch(e){
      logError('the status code of getting event categories is ${e.toString()}');
      return Left(AppExceptions(errorMessage: e.toString()));
    }
  }

    static EitherResponse getTrendingEvents()async{
    try{
      final response=await ApiServices.instance.getTrendingEvents();
      if(response.statusCode==200){
        return Right(response);
      }
      AppExceptions appExceptions=mapStatusCodeToException(response.statusCode);
      return Left(appExceptions);
    }catch(e){
      logError('the status code of getting trending events is ${e.toString()}');
      return Left(AppExceptions(errorMessage: e.toString()));
    }
  }

    static EitherResponse getAllEvents()async{
    try{
      final response=await ApiServices.instance.getAllEvents();
      if(response.statusCode==200){
        return Right(response);
      }
      AppExceptions appExceptions=mapStatusCodeToException(response.statusCode);
      return Left(appExceptions);
    }catch(e){
      logError('the status code of getting all events is ${e.toString()}');
      return Left(AppExceptions(errorMessage: e.toString()));
    }
  }

      static EitherResponse getEventsByLocation(int id) async {
    try {
      final response = await ApiServices.instance.getEventByLocation(id);
      
      if (response.statusCode == 201 || response.statusCode == 200) {
        return Right(response);
      } 
        AppExceptions appExceptions= mapStatusCodeToException(response.statusCode);
        return Left(appExceptions);
    } catch (e) {
      return Left(AppExceptions(errorMessage: e.toString()));
    }
  }

  
      static EitherResponse getEventDetails(int id) async {
    try {
      final response = await ApiServices.instance.getEventDetails(id);
      
      if (response.statusCode == 201 || response.statusCode == 200) {
        return Right(response);
      } 
        AppExceptions appExceptions= mapStatusCodeToException(response.statusCode);
        logError('the status code of getting event details is ${response.statusCode}');
        return Left(appExceptions);
    } catch (e) {
      logError('the status code of getting event details is $e');
      return Left(AppExceptions(errorMessage: e.toString()));
    }
  }


        static EitherResponse getMoreEvents(String nextPageUrl) async {
    try {
      final response = await ApiServices.instance.getMoreEvents(nextPageUrl);
      
      if (response.statusCode == 201 || response.statusCode == 200) {
        return Right(response);
      } 
        AppExceptions appExceptions= mapStatusCodeToException(response.statusCode);
        logError('the status code of getting event details is ${response.statusCode}');
        return Left(appExceptions);
    } catch (e) {
      logError('the status code of getting event details is $e');
      return Left(AppExceptions(errorMessage: e.toString()));
    }
  }
}