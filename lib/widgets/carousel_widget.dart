import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:evento_event_booking/blocs/event/bloc/event_bloc.dart';
import 'package:evento_event_booking/models/event_model.dart';
import 'package:evento_event_booking/resources/constants/image_paths.dart';
import 'package:evento_event_booking/resources/constants/text_styles.dart';
import 'package:evento_event_booking/resources/constants/user_colors.dart';
import 'package:evento_event_booking/utils/appthemes.dart';
import 'package:evento_event_booking/utils/cache_manager.dart';
import 'package:evento_event_booking/utils/progress_indicator.dart';
import 'package:evento_event_booking/view/events/single_event.dart';
import 'package:evento_event_booking/widgets/custom_button_black.dart';
import 'package:evento_event_booking/widgets/custom_cachednetwork_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventCarousel extends StatelessWidget {
  final List<EventModel> eventImages;

  const EventCarousel({required this.eventImages, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return CarouselSlider(
      options: CarouselOptions(
        autoPlayAnimationDuration: Duration(milliseconds: 500),
        viewportFraction: 0.85,
        // autoPlayCurve: Curves.easeInCubic,
        animateToClosest: false,
        padEnds: false,
        height: 100,
        autoPlay: true,
        enlargeCenterPage: false,
      ),
      items: eventImages.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              // padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // color: Colors.amber,
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CustomCachedNetworkImage(imageUrl: image.event_img_1),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(image.event_name, style: theme.textTheme.headlineLarge),
                        Text(image.location ?? 'Not available', style: theme.textTheme.headlineLarge),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: CustomButtonBlack(
                      ontap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EventDetailsScreen(eventModel: image,)));
                      },
                      elevation: 20,
                      color: AppColors.accentColor,
                      width: 70,
                      height: 30,
                      text: 'Book now',
                      buttonTextStyle: theme.textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}