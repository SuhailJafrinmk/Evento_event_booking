class AppExceptions implements Exception{
  final String errorMessage;
  AppExceptions({required this.errorMessage});
} 
class InternetException extends AppExceptions{
  InternetException() : super(errorMessage: 'no internet connection');
}
class ServerException extends AppExceptions{
  ServerException() : super(errorMessage: 'Something went wrong');
}
class RequestTimeOutException extends AppExceptions{
  RequestTimeOutException() : super(errorMessage: 'Request time out');
}
class UnauthorizedException extends AppExceptions{
  UnauthorizedException() : super(errorMessage: 'User not autherised');
}
class ResourceNotFoundException extends AppExceptions{
  ResourceNotFoundException() : super(errorMessage: 'Resource not found');
}
class InternalServerException extends AppExceptions{
  InternalServerException() : super(errorMessage: 'Issue with the server');
}
