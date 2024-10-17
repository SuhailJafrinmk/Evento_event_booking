import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body:  Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Who We Are',
                style: theme.textTheme.headlineLarge
              ),
              SizedBox(height: 8),
              Text(
                'We are Evento, a leading platform dedicated to making event booking and hosting easier than ever. '
                'Whether you\'re looking to book an exciting event or host one as a vendor, our platform provides a '
                'seamless experience tailored to your needs. With our user-friendly interface and wide range of events, '
                'we aim to connect people with unforgettable experiences.',
                style: theme.textTheme.titleSmall?.copyWith(color: Colors.white),
              ),
              SizedBox(height: 16),
              Text(
              'What We Offer',
              style: theme.textTheme.headlineLarge
              ),
              SizedBox(height: 8),
              Text(
                'For users, we offer a wide variety of events to choose from—whether you\'re looking for adventure, '
                'relaxation, or cultural experiences, Evento has it all. For vendors, we provide a powerful platform '
                'to showcase and manage your events, giving you the tools to succeed and reach a larger audience.',
               style: theme.textTheme.titleSmall?.copyWith(color: Colors.white),
              ),
              SizedBox(height: 16),
              Text(
                'Our Mission',
                style: theme.textTheme.headlineLarge
              ),
              SizedBox(height: 8),
              Text(
                'Our mission is to bridge the gap between event enthusiasts and hosts, making it easy for users to '
                'find and book events and for vendors to manage and promote their events. We strive to create an '
                'ecosystem where every event is a success, bringing joy to both attendees and hosts.',
                style: theme.textTheme.titleSmall?.copyWith(color: Colors.white),
              ),
              SizedBox(height: 16),
              Text(
                'Why Choose Evento?',
                style: theme.textTheme.headlineLarge
              ),
              SizedBox(height: 8),
              Text(
                'Evento is your one-stop solution for all event-related needs. With our cutting-edge technology, '
                'secure payment options, and dedicated support, we ensure that both users and vendors have a hassle-free experience. '
                'Whether you\'re attending or hosting, Evento is here to make your event memorable.',
                style: theme.textTheme.titleSmall?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
