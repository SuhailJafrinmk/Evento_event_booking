part of 'ticket_booking_bloc.dart';

@immutable
sealed class TicketBookingState {}
final class TicketBookingInitial extends TicketBookingState {}
class TicketBookingLoadingState extends TicketBookingState{}
class TicketBookedSuccess extends TicketBookingState{
  final String message;
  TicketBookedSuccess({required this.message});
}
class TicketBookingFailed extends TicketBookingState{
  final String message;
  TicketBookingFailed({required this.message});
}
class BookedTicketsLoading extends TicketBookingState{}
class BookedTicketsFetched extends TicketBookingState{
  final List<BookedTicketModel> bookedTickets;
  BookedTicketsFetched({required this.bookedTickets});
}
class ErrorFetchingBookedTickets extends TicketBookingState{
  final String errorMessage;
  ErrorFetchingBookedTickets({required this.errorMessage});
}

