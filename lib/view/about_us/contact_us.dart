import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Contact us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('You can get in touch with us through the following platforms,Our team will reach you out as soon as possible',style: theme.textTheme.headlineMedium?.copyWith(color: Colors.white54),),
            ),
            const SizedBox(height: 10,),
            Card(
              shadowColor: Colors.amber,
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('Customer Support',style: theme.textTheme.headlineLarge?.copyWith(color: Colors.black),),
                    const ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.call),
                      ),
                      title: Text('Contact number'),
                      subtitle: Text('+91 7306548087'),
                    ),
                    const ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.mail),
                      ),
                      title: const Text('Email address'),
                      subtitle: Text('evento@gmail.com'),
                    ),
                     const ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.location_on,color: Colors.red,),
                      ),
                      title: Text('Visit us'),
                      subtitle: Text('123 Event Venue Road, City, Country'),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}