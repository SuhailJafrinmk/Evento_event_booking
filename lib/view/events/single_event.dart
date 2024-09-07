import 'package:evento_event_booking/resources/constants/image_paths.dart';
import 'package:flutter/material.dart';


class EventDetailsScreen extends StatefulWidget {
  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back action
          },
        ),
        title: Text('Event details'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              // Handle favorite action
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Handle share action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(
                placeholderImage,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Event title',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white54,
              ),
            ),
            Text(
              'Kirans wedding',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  '9 August 2024',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(width: 24),
                Icon(Icons.access_time, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  '09:00 am',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Event details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'First marriage of kiran. All are invited to the aws auditorium chevayoor. Bring maximum people from your neighbourhood.',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                Chip(
                  label: Text('Cultural'),
                  backgroundColor: Colors.white12,
                  labelStyle: TextStyle(color: Colors.white),
                ),
                Chip(
                  label: Text('Eventeazz'),
                  backgroundColor: Colors.white12,
                  labelStyle: TextStyle(color: Colors.white),
                  avatar: Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
            Spacer(),
            Text(
              'Total 120 people have booked this event',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle booking action
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Book now',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
