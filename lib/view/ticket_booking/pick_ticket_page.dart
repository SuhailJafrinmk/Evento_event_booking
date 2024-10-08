import 'package:evento_event_booking/models/event_model.dart';
import 'package:evento_event_booking/resources/constants/image_paths.dart';
import 'package:evento_event_booking/widgets/ticket_widget.dart';
import 'package:flutter/material.dart';

class TicketBookingScreen extends StatefulWidget {
  final EventModel eventModel;
  const TicketBookingScreen({super.key, required this.eventModel});
  
  @override
  _TicketBookingScreenState createState() => _TicketBookingScreenState();
}

class _TicketBookingScreenState extends State<TicketBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F5F0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header Image
            Stack(
              children: [
                Image.network(
                  widget.eventModel.event_img_1 ?? placeholderImage, // Replace with your actual image
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Text(
                    'Select your ticket',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            // 2. Event Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.eventModel.event_name, // Use actual event name
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.calendar_today, size: 20),
                      SizedBox(width: 8),
                      Text('9 August 2024', style: TextStyle(fontSize: 16)), // Use actual event date
                      SizedBox(width: 20),
                      Icon(Icons.access_time, size: 20),
                      SizedBox(width: 8),
                      Text('09:00 am', style: TextStyle(fontSize: 16)), // Use actual event time
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 20),
                      SizedBox(width: 8),
                      Text('Nalanda auditorium calicut', style: TextStyle(fontSize: 16)), // Use actual event location
                    ],
                  ),
                ],
              ),
            ),

            // 3. Ticket Cards
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: widget.eventModel.ticket_types!.map((ticketType) {
                  return TicketCard(
                    eventModel: widget.eventModel,
                    ticketType: ticketType,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
