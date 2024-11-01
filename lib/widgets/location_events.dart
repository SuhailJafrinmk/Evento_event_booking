import 'package:evento_event_booking/blocs/favourites/bloc/favourites_bloc.dart';
import 'package:evento_event_booking/data/hive/hive_helper.dart';
import 'package:evento_event_booking/models/event_model.dart';
import 'package:evento_event_booking/resources/constants/user_colors.dart';
import 'package:evento_event_booking/view/events/single_event.dart';
import 'package:evento_event_booking/widgets/custom_cachednetwork_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

class LocationEvents extends StatelessWidget {
  final List<EventModel> eventModel;

  LocationEvents({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    // Fetch favorite events from Hive
    List<EventModel> favouriteEvents = HiveHelper().getFavourites();
    final theme = Theme.of(context);

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: eventModel.length,
        itemBuilder: (context, index) {
          final EventModel item = eventModel[index];
          final date = item.end_date.split(',');

          // Check if the current event is a favorite by comparing event id
          bool isFavourite = favouriteEvents.any((favEvent) => favEvent.id == item.id);

          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => EventDetailsScreen(eventModel: item),
              ));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CustomCachedNetworkImage(
                            imageUrl: item.event_img_1,
                            height: 130,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ShapeOfView(
                              elevation: 20,
                              shape: CutCornerShape(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Container(
                                height: 35,
                                width: 70,
                                color: AppColors.accentColor,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      date[0],
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.textTheme.labelLarge?.copyWith(fontSize: 8),
                                    ),
                                    Text(
                                      date[1],
                                      style: theme.textTheme.labelLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Favorite icon logic
                            IconButton(
                              onPressed: () {
                                // Implement logic to add/remove from favourites
                                if (isFavourite) {
                                  BlocProvider.of<FavouritesBloc>(context).add(DeleteFavouriteEvent(eventModel: item));
                                } else {
                                  BlocProvider.of<FavouritesBloc>(context).add(AddToFavouritesEvent(eventModel: item));
                                }
                                // Optionally, call setState or use a state management solution to update UI
                              },
                              icon: Icon(
                                isFavourite
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_outlined,
                                color: isFavourite ? Colors.red : Colors.white,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 60,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.event_name,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.about ?? 'Not available',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
