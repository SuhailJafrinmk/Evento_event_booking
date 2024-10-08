part of 'ticket_booking_bloc.dart';

@immutable
sealed class TicketBookingEvent {}
class BookAnEvent extends TicketBookingEvent{
  final TicketType ticketType;
  final int ticketCount;
  BookAnEvent({required this.ticketType, required this.ticketCount});
}
