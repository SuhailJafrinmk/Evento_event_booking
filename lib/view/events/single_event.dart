import 'package:evento_event_booking/blocs/favourites/bloc/favourites_bloc.dart';
import 'package:evento_event_booking/blocs/share/share_bloc.dart';
import 'package:evento_event_booking/development_only/custom_logger.dart';
import 'package:evento_event_booking/models/event_model.dart';
import 'package:evento_event_booking/resources/api_urls/api_urls.dart';
import 'package:evento_event_booking/resources/constants/image_paths.dart';
import 'package:evento_event_booking/resources/constants/user_colors.dart';
import 'package:evento_event_booking/utils/snackbar.dart';
import 'package:evento_event_booking/utils/utility_functions.dart';
import 'package:evento_event_booking/view/ticket_booking/pick_ticket_page.dart';
import 'package:evento_event_booking/widgets/custom_button_black.dart';
import 'package:evento_event_booking/widgets/custom_cachednetwork_image.dart';
import 'package:evento_event_booking/widgets/pill_shaped_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventDetailsScreen extends StatefulWidget {
  final EventModel eventModel;
  const EventDetailsScreen({super.key, required this.eventModel});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  late bool isEventFavourite;

  @override
  void initState() {
    super.initState();
    // Initialize the favorite state based on the event
    isEventFavourite = UtilityFunctions.isFavourite(widget.eventModel);
    logInfo('the value of isEventFavourite is $isEventFavourite');
  }

  void toggleFavourite() {
      if (isEventFavourite == true) {
        logInfo('the event is a favourite and we will be deleting it from favourites');
      BlocProvider.of<FavouritesBloc>(context)
          .add(DeleteFavouriteEvent(eventModel: widget.eventModel));
    } else {
      logInfo('the event is not a favourite and we will be adding it to favourites');
      BlocProvider.of<FavouritesBloc>(context)
          .add(AddToFavouritesEvent(eventModel: widget.eventModel));
    }
    setState(() {
      isEventFavourite = !isEventFavourite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final date = widget.eventModel.start_date.split(',');
    final theme = Theme.of(context);
    String imageUrl = widget.eventModel.event_img_1!.contains(ApiUrls.baseUrl)
        ? widget.eventModel.event_img_1 ?? placeholderImage
        : '${ApiUrls.baseUrl}${widget.eventModel.event_img_1}';

    return BlocListener<FavouritesBloc, FavouritesState>(
      listener: (context, state) {
        if(state is AddToFavouritesSuccess){
          ScaffoldMessenger.of(context).showSnackBar(customSnackbar(context, true, 'successfully added to favourites'));
        }else if(state is DeleteFromFavouritesSuccess){
          ScaffoldMessenger.of(context).showSnackBar(customSnackbar(context, true, 'deleted from favourites'));
        }else if(state is ErrorAddingToFavourites){
          ScaffoldMessenger.of(context).showSnackBar(customSnackbar(context, false, 'error adding to favouries'));
        }else if(state is ErrorDeletingFromFavourites){
          ScaffoldMessenger.of(context).showSnackBar(customSnackbar(context, false, 'eroor occured'));
        }
      },
      child: Scaffold(
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
          title: Text(
            'Event details',
            style: theme.textTheme.headlineLarge,
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: isEventFavourite ? Colors.red : Colors.white,
              ),
              onPressed: toggleFavourite,
            ),
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                // Trigger the share event
                BlocProvider.of<ShareBloc>(context)
                    .add(ShareAnEvent(eventModel: widget.eventModel));
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
                    height: size.height * .2,
                    width: size.width,
                    imageUrl: imageUrl),
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
                widget.eventModel.event_name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  PillContainer(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(Icons.calendar_today,
                          color: AppColors.categoryBackgroundColor),
                      Text(
                        date[0],
                        style: theme.textTheme.labelLarge,
                      ),
                    ],
                  )),
                  const SizedBox(width: 24),
                  PillContainer(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(Icons.access_time,
                          color: AppColors.categoryBackgroundColor),
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
                height: size.height * .2,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                    widget.eventModel.about ?? 'no descriptions',
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
                ontap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          TicketBookingScreen(eventModel: widget.eventModel)));
                },
                buttonTextStyle:
                    theme.textTheme.labelLarge?.copyWith(fontSize: 17),
                color: AppColors.accentColor,
                text: 'Book now',
              )
            ],
          ),
        ),
      ),
    );
  }
}
