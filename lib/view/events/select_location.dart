import 'package:evento_event_booking/blocs/event/bloc/event_bloc.dart';
import 'package:evento_event_booking/data/shared_preferences/shared_preferences.dart';
import 'package:evento_event_booking/resources/constants/text_styles.dart';
import 'package:evento_event_booking/view/home/home_screen.dart';
import 'package:evento_event_booking/view/home/main_navigation_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationSelectionPage extends StatefulWidget {
  @override
  _LocationSelectionPageState createState() => _LocationSelectionPageState();
}

class _LocationSelectionPageState extends State<LocationSelectionPage> {
  String? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location', style: montserratMedium),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // BlocBuilder to listen to the EventBloc and update the UI
            BlocBuilder<EventBloc, EventState>(
              builder: (context, state) {
                // Check if the state is EventStateLoaded to access event locations
                if (state is EventStateLoaded) {
                  // Show loading indicator while fetching data
                  if (state.isLoading && state.eventLocations.isEmpty) {
                    return Center(child: CircularProgressIndicator());
                  }

                  // Check if there are any errors
                  if (state.errorMessage != null) {
                    return Text(
                      'Failed to load locations. Please try again.',
                      style: TextStyle(color: Colors.red),
                    );
                  }

                  // Update the dropdown with the fetched locations
                  final locations = state.eventLocations;

                  return DropdownButtonFormField<String>(
                    dropdownColor: Colors.black,
                    style: montserratMedium,
                    value: selectedLocation,
                    hint: Text('Select a location'),
                    items: locations.map((e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedLocation = newValue;
                      });
                    },
                  );
                } else {
                  // Show loading or an empty state if data is not yet loaded
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedLocation != null) {
                  // Handle the submission logic here
                  print('Selected Location: $selectedLocation');
                  SharedPref.instance.storeUserLocation(selectedLocation);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainNavigationWrapper()));
                } else {
                  // Show a message or handle the case where no location is selected
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select a location.')),
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
