import 'package:evento_event_booking/blocs/ticket_booking/bloc/ticket_booking_bloc.dart';
import 'package:evento_event_booking/models/event_model.dart';
import 'package:evento_event_booking/models/ticket_model.dart';
import 'package:evento_event_booking/resources/constants/image_paths.dart';
import 'package:evento_event_booking/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketCard extends StatefulWidget {
  final EventModel eventModel;
  final TicketType ticketType;
  TicketCard({super.key,required this.eventModel,required this.ticketType});
  @override
  _TicketCardState createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard> {
  int quantity = 1;
  final int maxQuantity = 5; // Max ticket count restriction

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5), // light background color
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.black12), // light border color
        ),
        child: Row(
          children: [
            // Ticket Image
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  widget.ticketType.ticketImage ?? placeholderImage,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Ticket Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.ticketType.typeName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0),
                  Text('Rs: ${widget.ticketType.price}',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 4.0),
                  Text('${widget.ticketType.soldCount} left',
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            ),

            // Quantity Selector & Checkout Button
            Column(
              children: [
                // Quantity selector
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (quantity > 1) {
                          setState(() {
                            quantity--;
                          });
                        }
                      },
                      icon: Icon(Icons.remove_circle_outline),
                    ),
                    Text('$quantity',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    IconButton(
                      onPressed: () {
                        if (quantity < maxQuantity) {
                          setState(() {
                            quantity++;
                          });
                        } else {
                          // Show Snackbar if maxQuantity is reached
                          ScaffoldMessenger.of(context).showSnackBar(
                           customSnackbar(context, false, 'Maximum 5 tickets only allowed'),
                          );
                        }
                      },
                      icon: Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),

                // Checkout Button
                ElevatedButton(
                  onPressed: () {
                   BlocProvider.of<TicketBookingBloc>(context).add(BookAnEvent(ticketType: widget.ticketType, ticketCount: quantity));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
  
                  ),
                  child: Text('Checkout'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

