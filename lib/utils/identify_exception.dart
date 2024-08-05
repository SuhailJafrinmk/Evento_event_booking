
import 'package:evento_event_booking/utils/app_exceptions.dart';

AppExceptions mapStatusCodeToException(int ? statusCode) {
  switch (statusCode) {
    case 400:
      return AppExceptions(errorMessage: 'Bad request');
    case 401:
      return UnauthorizedException();
    case 403:
      return AppExceptions(errorMessage: 'Forbidden');
    case 404:
      return ResourceNotFoundException();
    case 405:
      return AppExceptions(errorMessage: "Method not allowed");
    case 408:
      return RequestTimeOutException();
    case 409:
      return AppExceptions(errorMessage: 'Conflict');
    case 429:
      return AppExceptions(errorMessage: 'Too many requests');
    case 500:
      return InternalServerException();
    case 501:
      return AppExceptions(errorMessage: 'not implemented');
    case 502:
      return AppExceptions(errorMessage: 'Bad gateway');
    case 503:
      return AppExceptions(errorMessage: 'Service unavailable');
    case 504:
      return AppExceptions(errorMessage: 'Gate-way time out');
    default:
      return AppExceptions(errorMessage: 'ERror! $statusCode');
  }
}
