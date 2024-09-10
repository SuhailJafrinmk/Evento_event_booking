import 'package:either_dart/either.dart';
import 'package:evento_event_booking/data/network/api_services.dart';
import 'package:evento_event_booking/development_only/custom_logger.dart';
import 'package:evento_event_booking/utils/app_exceptions.dart';
import 'package:evento_event_booking/utils/identify_exception.dart';

class FavouritesRepo {
  static EitherResponse addToFavourites(int id) async {
    try {
      final response = await ApiServices.instance.addToFavourites(id);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(response);
      }
      AppExceptions appExceptions =
          mapStatusCodeToException(response.statusCode);
      return Left(appExceptions);
    } catch (e) {
      logError(
          'the error while adding an event to favourites is ${e.toString()}');
      return Left(AppExceptions(errorMessage: e.toString()));
    }
  }

  static EitherResponse getAllFavourites() async {
    try {
      final response = await ApiServices.instance.getAllFavourites();
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(response);
      }
      AppExceptions appExceptions =
          mapStatusCodeToException(response.statusCode);
      return Left(appExceptions);
    } catch (e) {
      logError('the error while getting favorites events is ${e.toString()}');
      return Left(AppExceptions(errorMessage: e.toString()));
    }
  }

  static EitherResponse deleteFromFavourites(int id) async {
    try {
      final response = await ApiServices.instance.deleteFromFavourites(id);
      if (response.statusCode == 200) {
        return Right(response);
      }
      AppExceptions appExceptions =
          mapStatusCodeToException(response.statusCode);
      return Left(appExceptions);
    } catch (e) {
      logError(
          'the error while deleting a favourited event is ${e.toString()}');
      return Left(AppExceptions(errorMessage: e.toString()));
    }
  }
}
