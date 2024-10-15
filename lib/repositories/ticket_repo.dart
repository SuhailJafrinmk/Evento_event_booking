import 'package:either_dart/either.dart';
import 'package:evento_event_booking/data/network/api_services.dart';
import 'package:evento_event_booking/development_only/custom_logger.dart';
import 'package:evento_event_booking/utils/app_exceptions.dart';
import 'package:evento_event_booking/utils/identify_exception.dart';



class TicketRepo{
  static EitherResponse bookATicket(int ticketId,int ticketCount) async {
    try {
      final response = await ApiServices.instance.bookMyTicket(ticketId,ticketCount);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(response);
      } else {
        AppExceptions exceptions =
            mapStatusCodeToException(response.statusCode);
        return Left(exceptions);
      }
    } catch (e) {
      logError('an error ocuured while booking a ticket ${e.toString()}');
      return Left(AppExceptions(errorMessage: e.toString()));
    }
  }

  static EitherResponse confirmTicket(Map<String,dynamic> data)async{
    try {
      final response=await ApiServices.instance.confirmTicket(data);
      if(response.statusCode==200||response.statusCode==201){
        return Right(response);
      }
      AppExceptions exceptions=mapStatusCodeToException(response.statusCode);
      return Left(exceptions);
    } catch (e) {
      logError('an error cocured while confirming ticket ${e.toString()}');
      return Left(AppExceptions(errorMessage: e.toString()));
    }
  }

    static EitherResponse getBookedTickets()async{
      try {
        final response=await ApiServices.instance.getBookedTickets();
        if(response.statusCode==200){
          return Right(response);
        }
        AppExceptions exceptions=mapStatusCodeToException(response.statusCode);
        return Left(exceptions);
      } catch (e) {
        logError('an errror occured while fetching booked tickets ${e.toString()}');
        return Left(AppExceptions(errorMessage: e.toString()));
      }
    }
}
