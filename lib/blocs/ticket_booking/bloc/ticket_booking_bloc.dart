import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:evento_event_booking/development_only/custom_logger.dart';
import 'package:evento_event_booking/models/booked_ticket_model.dart';
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
    on<GetBookedTickets>(getBookedTickets);

    // Register the Razorpay event listeners only once in the constructor
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  final _razorpay = Razorpay();
  Map<String, dynamic> bookingData = {};

  FutureOr<void> bookAnEvent(BookAnEvent event, Emitter<TicketBookingState> emit) async {
    emit(TicketBookingLoadingState());
    
    bookingData = {
      'ticket_id': event.ticketType.id,
      'ticket_count': event.ticketCount,
    };

    final response = await TicketRepo.bookATicket(event.ticketType.id, event.ticketCount);
    
    response.fold(
      (failure) {
        emit(TicketBookingFailed(message: failure.errorMessage));
      }, 
      (success) {
        bookingData['order_id'] = success.data['order_id'];
        var options = {
          'key': dotenv.env['RAZORPAY_KEY'],
          'amount': success.data['amount'],
          'name': 'Evento.ink',
          'description': 'Your favourite events',
          'order_id': bookingData['order_id'],
          'prefill': {
            'contact': '7306548087',
            'email': 'suhailmk196@gmail.com'
          }
        };

        _razorpay.open(options);
        emit(TicketBookedSuccess(message: 'Successfully booked ${event.ticketCount}'));
      }
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse paymentSuccessResponse) async {
    logInfo('Inside the confirm ticket method');
    final data = {
      'order_id': paymentSuccessResponse.orderId,
      'payment_id': paymentSuccessResponse.paymentId,
      'ticket_id': bookingData['ticket_id'],
      'ticket_count': bookingData['ticket_count'],
    };

    final response = await TicketRepo.confirmTicket(data);

    // After successful confirmation, you can optionally unregister the listeners if needed
    _razorpay.clear();
  }

  void _handlePaymentError(PaymentFailureResponse paymentFailureResponse) {
    emit(TicketBookingFailed(message: 'Ticket booking failed'));
    
    // Optionally, clear listeners on error too
    _razorpay.clear();
  }

  @override
  Future<void> close() {
    // Ensure you clear all Razorpay listeners when the Bloc is closed
    _razorpay.clear();
    return super.close();
  }

  FutureOr<void> getBookedTickets(GetBookedTickets event, Emitter<TicketBookingState> emit)async{
    emit(BookedTicketsLoading());
    final response=await TicketRepo.getBookedTickets();
    response.fold((error){
      emit(ErrorFetchingBookedTickets(errorMessage: error.errorMessage));
    }, (success){
      final data=success.data as List<dynamic>;
      final List<BookedTicketModel> tickets=data.map((item)=>BookedTicketModel.fromJson(item as Map<String,dynamic>)).toList();
      emit(BookedTicketsFetched(bookedTickets: tickets));
    });
  }
}
