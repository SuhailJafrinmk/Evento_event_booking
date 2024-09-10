import 'package:evento_event_booking/blocs/event/bloc/event_bloc.dart';
import 'package:evento_event_booking/data/shared_preferences/shared_preferences.dart';
import 'package:evento_event_booking/models/location_model.dart';
import 'package:evento_event_booking/resources/constants/user_colors.dart';
import 'package:evento_event_booking/view/home/main_navigation_wrapper.dart';
import 'package:evento_event_booking/widgets/custom_button_black.dart';
import 'package:evento_event_booking/widgets/normal_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationSelectionPage extends StatefulWidget {
  @override
  _LocationSelectionPageState createState() => _LocationSelectionPageState();
}

class _LocationSelectionPageState extends State<LocationSelectionPage> {
  EventLocations? selectedLocation;

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Scaffold(
      appBar: CustomAppbar(title: 'Select location'),
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
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Check if there are any errors
                  if (state.errorMessage != null) {
                    return const Text(
                      'Failed to load locations. Please try again.',
                      style: TextStyle(color: Colors.red),
                    );
                  }

                  // Update the dropdown with the fetched locations
                  final locations = state.eventLocations;

                  return DropdownButtonFormField<EventLocations>(
                    dropdownColor: Colors.black,
                    style: theme.textTheme.displayMedium?.copyWith(color: AppColors.cardBackgroundColor),
                    value: selectedLocation,
                    hint: Text('Select a location',style: theme.textTheme.displaySmall?.copyWith(color: AppColors.cardBackgroundColor),),
                    items: locations.map((e) {
                      return DropdownMenuItem<EventLocations>(
                        value: e,
                        child: Text(e.name),
                      );
                    }).toList(),
                    onChanged: (EventLocations? newValue) {
                      setState(() {
                        selectedLocation = newValue;
                      });
                    },
                  );
                } else {
                  // Show loading or an empty state if data is not yet loaded
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            const SizedBox(height: 20),
            CustomButtonBlack(
              color: AppColors.accentColor,
              text: 'Add Location',
              textColor: AppColors.backgroundColor,
              ontap: () {
                 if (selectedLocation != null) {
                  // Handle the submission logic here
                  print('Selected Location: $selectedLocation');
                  SharedPref.instance.storeUserLocation(selectedLocation);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainNavigationWrapper()));
                } else {
                  // Show a message or handle the case where no location is selected
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a location.')),
                  );
                }
              
              },
              )
          ],
        ),
      ),
    );
  }
}
