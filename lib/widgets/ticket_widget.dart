import 'package:evento_event_booking/models/event_model.dart';
import 'package:evento_event_booking/models/ticket_model.dart';
import 'package:evento_event_booking/resources/constants/image_paths.dart';
import 'package:evento_event_booking/utils/snackbar.dart';
import 'package:evento_event_booking/view/ticket_booking/ticket_confirmation.dart';
import 'package:evento_event_booking/widgets/custom_cachednetwork_image.dart';
import 'package:flutter/material.dart';

class TicketCard extends StatefulWidget {
  final EventModel eventModel;
  final TicketType ticketType;
  TicketCard({super.key,required this.eventModel,required this.ticketType});
  @override
  _TicketCardState createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard> {
  int quantity = 1;
  final int maxQuantity = 5;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          children: [
            // Ticket Image
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CustomCachedNetworkImage(
                  imageUrl: widget.ticketType.ticketImage ?? placeholderImage,
                  height: 100,
                  width: 100,
                  ),
              ),
            ),

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
                  Text('${widget.ticketType.count-widget.ticketType.soldCount} left',
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            ),
            Column(
              children: [
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
                          ScaffoldMessenger.of(context).showSnackBar(
                           customSnackbar(context, false, 'Maximum 5 tickets only allowed'),
                          );
                        }
                      },
                      icon: Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                  TicketConfirmationPage(
                    eventModel: widget.eventModel,
                    ticketType: widget.ticketType,
                    ticketQuantity: quantity,
                    )));
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

