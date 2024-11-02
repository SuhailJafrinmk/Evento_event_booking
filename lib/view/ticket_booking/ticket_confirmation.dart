import 'package:evento_event_booking/blocs/ticket_booking/bloc/ticket_booking_bloc.dart';
import 'package:evento_event_booking/models/event_model.dart';
import 'package:evento_event_booking/models/ticket_model.dart';
import 'package:evento_event_booking/resources/constants/user_colors.dart';
import 'package:evento_event_booking/utils/progress_indicator.dart';
import 'package:evento_event_booking/widgets/custom_button_black.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketConfirmationPage extends StatelessWidget {
  final EventModel eventModel;
  final TicketType ticketType;
  final int ticketQuantity;
  const TicketConfirmationPage({
    Key? key,
    required this.eventModel,
    required this.ticketType,
    required this.ticketQuantity
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             Text(
              'Order Summary',
              style: theme.textTheme.displayLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username: Suhail',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Event: ${eventModel.event_name}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Date: ${eventModel.end_date}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Charges Breakdown:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildChargeRow('Total:', double.parse(ticketType.price)*ticketQuantity),
                    _buildChargeRow('Booking Fee:', double.parse(ticketType.price)*ticketQuantity*0.04),
                    _buildChargeRow('CGST:', double.parse(ticketType.price)*ticketQuantity * 0.05),
                    _buildChargeRow('SGST:', double.parse(ticketType.price)*ticketQuantity*0.05),
                    const Divider(
                      height: 20,
                      color: Colors.black,
                    ),
                    _buildChargeRow('Total Cost:', getSubTotal(ticketType.price, ticketQuantity), isTotal: true),
                  ],
                ),
              ),
            ),
            const Spacer(),
            CustomElevatedButton(
              
              buttonChild: BlocBuilder<TicketBookingBloc, TicketBookingState>(
                builder: (context, state) {
                  if(state is TicketBookingLoadingState){
                    return const CustomProgressIndicator(color: Colors.black,);
                  }
                  return Text("Book now");
                },
              ),
               onTap: () {
                BlocProvider.of<TicketBookingBloc>(context).add(BookAnEvent(ticketType: ticketType, ticketCount: ticketQuantity));
              },   
              )
            // CustomButtonBlack(
            //   text: 'Book now',
            //   color: AppColors.accentColor,
            //   ontap: () {
            //     BlocProvider.of<TicketBookingBloc>(context).add(BookAnEvent(ticketType: ticketType, ticketCount: ticketQuantity));
            //   },            
            // ),
          ],
        ),
      ),
    );
  }

  // Widget to build each row for charges
  Widget _buildChargeRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            '₹ ${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

double getSubTotal(String price,int quantity){
  double total=double.parse(price)*quantity;
  double bookingFee=total * 0.04;
  double tax=total *0.1;
  return total+bookingFee+tax;
}