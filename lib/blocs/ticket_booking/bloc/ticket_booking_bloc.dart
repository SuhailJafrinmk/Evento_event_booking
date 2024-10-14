import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:evento_event_booking/models/ticket_model.dart';
import 'package:evento_event_booking/repositories/ticket_repo.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:meta/meta.dart';
part 'ticket_booking_event.dart';
part 'ticket_booking_state.dart';

class TicketBookingBloc extends Bloc<TicketBookingEvent, TicketBookingState> {
  TicketBookingBloc() : super(TicketBookingInitial()) {
    on<BookAnEvent>(bookAnEvent);
  }
  final _razorpay=Razorpay();
  Map<String,dynamic> bookingData={};

  FutureOr<void> bookAnEvent(BookAnEvent event, Emitter<TicketBookingState> emit)async{
    emit(TicketBookingLoadingState());
    final response=await TicketRepo.bookATicket(event.ticketType.id,event.ticketCount);
    response.fold(
      (failure){
        emit(TicketBookingFailed(message: failure.errorMessage));
      }, 
      (success){
          var options={
          'key':dotenv.env['RAZORPAY_KEY'],
          'amount':success.data['amount'],
          'name':'Evento.ink',
          'description':'Your favourite events',
          'prefill':{
            'contact':'7306548087',
            'email':'suhailmk196@gmail.com'
          }
        };
        _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
        _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
        _razorpay.open(options);
        emit(TicketBookedSuccess(message: 'Successfully booked ${event.ticketCount}'));
      });
  }
  void _handlePaymentSuccess(PaymentSuccessResponse PaymentSuccessResponse){
    
  }
  void _handlePaymentError(PaymentFailureResponse PaymentFailureResponse){

  }
}
