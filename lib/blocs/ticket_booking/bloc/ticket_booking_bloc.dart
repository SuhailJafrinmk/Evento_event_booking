import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:evento_event_booking/data/network/api_services.dart';
import 'package:evento_event_booking/models/event_model.dart';
import 'package:evento_event_booking/models/ticket_model.dart';
import 'package:evento_event_booking/repositories/ticket_repo.dart';
import 'package:meta/meta.dart';

part 'ticket_booking_event.dart';
part 'ticket_booking_state.dart';

class TicketBookingBloc extends Bloc<TicketBookingEvent, TicketBookingState> {
  TicketBookingBloc() : super(TicketBookingInitial()) {
    on<BookAnEvent>(bookAnEvent);
  }

  FutureOr<void> bookAnEvent(BookAnEvent event, Emitter<TicketBookingState> emit)async{
    emit(TicketBookingLoadingState());
    final response=await TicketRepo.bookATicket(event.ticketType.id,event.ticketCount);
    response.fold(
      (failure){
        emit(TicketBookingFailed(message: failure.errorMessage));
      }, 
      (success){
        emit(TicketBookedSuccess(message: 'Successfully booked ${event.ticketCount}'));
      });
  }
}
