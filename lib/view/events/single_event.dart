import 'package:evento_event_booking/development_only/custom_logger.dart';
import 'package:evento_event_booking/models/event_model.dart';
import 'package:evento_event_booking/resources/constants/user_colors.dart';
import 'package:evento_event_booking/widgets/custom_button_black.dart';
import 'package:evento_event_booking/widgets/custom_cachednetwork_image.dart';
import 'package:evento_event_booking/widgets/pill_shaped_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventModel eventModel;
  const EventDetailsScreen({super.key, required this.eventModel});
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    final date=eventModel.end_date.split(',');
    final theme=Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:  Text('Event details',style: theme.textTheme.headlineLarge,),

        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              logInfo('the list is $date');
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
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
             child: CustomCachedNetworkImage(
              height: size.height*.2,
              width: size.width,
              imageUrl: eventModel.event_img_1),
            ),
            const SizedBox(height: 10),
            const Text(
              'Event title',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white54,
              ),
            ),
            Text(
              eventModel.event_name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                PillContainer(child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.calendar_today, color: AppColors.categoryBackgroundColor),
                     Text(
                  date[0],
                  style: theme.textTheme.labelLarge,
                ),
                  ],
                )),
                const SizedBox(width: 24),
                PillContainer(child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.access_time, color: AppColors.categoryBackgroundColor),
                     Text(
                  date[1],
                  style: theme.textTheme.labelLarge,
                ),
                  ],
                )),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Event details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: size.height*.2,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  eventModel.about ?? 'no descriptions',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Wrap(
              spacing: 8,
              children: [
                Chip(
                  label: Text('Cultural'),
                  backgroundColor: Colors.white12,
                  labelStyle: TextStyle(color: Colors.black),
                ),
                Chip(
                  label: Text('Eventeazz'),
                  backgroundColor: Colors.white12,
                  labelStyle: TextStyle(color: Colors.black),
                  avatar: Icon(Icons.add, color: Colors.black),
                ),
              ],
            ),
            const Spacer(),
            const Text(
              'Total 120 people have booked this event',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 16),
            CustomButtonBlack(
              buttonTextStyle: theme.textTheme.labelLarge?.copyWith(fontSize: 17),
              color: AppColors.accentColor,
              text: 'Book now')
          ],
        ),
      ),
    );
  }
}
