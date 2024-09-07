import 'package:evento_event_booking/blocs/event/bloc/event_bloc.dart';
import 'package:evento_event_booking/resources/constants/text_styles.dart';
import 'package:evento_event_booking/widgets/carousel_widget.dart';
import 'package:evento_event_booking/widgets/categories.dart';
import 'package:evento_event_booking/widgets/location_events.dart';
import 'package:evento_event_booking/widgets/trending_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class HomePage extends StatefulWidget {
  final String userName;
  HomePage({required this.userName});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    @override
  void initState() {
    super.initState();
        context.read<EventBloc>()
      ..add(FetchEventCategories())
      ..add(FetchTrendingEvents())
      ..add(FetchAllEvents())
      ..add(FetchEventByLocation());
      
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hey ${widget.userName}\nGood afternoon', style: montserratLarge),
            const SizedBox(height: 20),
            BlocBuilder<EventBloc, EventState>(
              builder: (context, state) {
                if (state is EventStateLoaded) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.errorMessage != null) {
                    return Text(
                      'Failed to load data: ${state.errorMessage}',
                      style: const TextStyle(color: Colors.red),
                    );
                  }
                  return Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          if (state.allEvents.isNotEmpty)
                            EventCarousel(eventImages: state.allEvents,),
                          const SizedBox(height: 20),
                          if (state.eventCategories.isNotEmpty)
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Categories',style: bodyText2.copyWith(fontSize: 20),),
                              Text('See all',style: bodyText2.copyWith(fontSize: 16),),
                            ],
                           ),
                           const SizedBox(height: 10,),
                            CategoriesList(categories: state.eventCategories),
                          const SizedBox(height: 20),
                          if (state.trendingEvents.isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Trending Events',style: bodyText2.copyWith(fontSize: 20),),
                              Text('See all',style: bodyText2.copyWith(fontSize: 16),),
                            ],
                           ),
                           const SizedBox(height: 10,),
                            TrendingEvents(trendingEvents: state.trendingEvents),
                           const SizedBox(height: 20),
                            Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Events at Malappuram',style: bodyText2.copyWith(fontSize: 20),),
                              Text('See all',style: bodyText2.copyWith(fontSize: 16),),
                            ],
                           ),
                           const SizedBox(height: 10,),
                           LocationEvents(eventModel: state.eventsAtLocation),   
                        ],
                      ),
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      );
  }
}