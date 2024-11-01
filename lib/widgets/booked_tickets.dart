import 'package:evento_event_booking/models/booked_ticket_model.dart';
import 'package:evento_event_booking/resources/constants/image_paths.dart';
import 'package:flutter/material.dart';

class BookedTickets extends StatelessWidget {
  final BookedTicketModel bookedTicketModel;

  const BookedTickets({super.key, required this.bookedTicketModel});

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Container(
      height: size.height*.2,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand, // Ensures the image and content fill the container
        children: [
          // Background image layer
          Image.asset(
            AssetImages.ticketImage,
            fit: BoxFit.cover, // Ensures the image covers the entire container
          ),
          // Texts and QR code layer
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                // Text section
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Event: ${bookedTicketModel.eventName}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Organizer: ${bookedTicketModel.organizerName}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Type: ${bookedTicketModel.typeName}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Date: ${bookedTicketModel.eventDate.toLocal().toString().split(' ')[0]}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Price: \$${bookedTicketModel.ticketPrice}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Tickets: ${bookedTicketModel.ticketCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Status: ${bookedTicketModel.ticketStatus}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                // QR code section
                Expanded(
                  flex: 1,
                  child: bookedTicketModel.qrCode != null
                      ? Padding(
                          padding: const EdgeInsets.all(2),
                          child: Image.network(
                            bookedTicketModel.qrCode!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: Text(
                              'No QR Code',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
