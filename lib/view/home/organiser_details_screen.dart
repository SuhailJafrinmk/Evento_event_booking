import 'package:evento_event_booking/resources/constants/image_paths.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

//some random commit on branch organiser_details
class OrganiserDetailsScreen extends StatelessWidget {
  final String? organiserName;
  final String? organiserEmail;
  final String? organiserPhone;
  final String? organiserId;
  final String? organiserImage;

  const OrganiserDetailsScreen({super.key, this.organiserName, this.organiserEmail, this.organiserPhone, this.organiserId, this.organiserImage});

  @override
  Widget build(BuildContext context) {
    developer.log('the organiser image is $organiserImage');
    final size=MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(
        title: Text('Organiser details'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: organiserImage!=null ? NetworkImage(organiserImage!) : AssetImage(AssetImages.profileAvatar) as ImageProvider,
            ),
            SizedBox(height: 20,),
            SizedBox(
              height: size.height*.3,
              child: Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Organiser name'),
                      subtitle: Text(organiserName ?? 'Not provided'),
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                       title: Text('Organiser email'),
                      subtitle: Text(organiserEmail ?? 'Not provided'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                       title: Text('Organiser phone'),
                      subtitle: Text(organiserPhone ?? 'Not provided'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}