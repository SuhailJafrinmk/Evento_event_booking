import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:evento_event_booking/blocs/event/bloc/event_bloc.dart';
import 'package:evento_event_booking/utils/progress_indicator.dart';
import 'package:evento_event_booking/view/home/category_page.dart';
import 'package:evento_event_booking/widgets/carousel_widget.dart';
import 'package:evento_event_booking/widgets/categories.dart';
import 'package:evento_event_booking/widgets/location_events.dart';
import 'package:evento_event_booking/widgets/trending_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


//some random text in homepage
class HomePage extends StatefulWidget {
  final String userName;
  final String userLocation;
  HomePage({required this.userName,required this.userLocation});

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
  //wjdwduqhuhduhduhwuhdqiuhwuhdquhwudh
  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hey ${widget.userName}',style:theme.textTheme.displayLarge,),
            AnimatedTextKit(
              repeatForever: false,
              animatedTexts: [
                TyperAnimatedText('Welcome',textStyle: theme.textTheme.displayLarge),
                TyperAnimatedText('${getWish(DateTime.now())}',textStyle:theme.textTheme.displayLarge),
              ]
              ),
            
            const SizedBox(height: 20),
            BlocBuilder<EventBloc, EventState>(
              builder: (context, state) {
                if (state is EventStateLoaded) {
                  if (state.isLoading) {
                    return const Center(child: CustomProgressIndicator(size: 30,));
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
                              Text('Categories',style: theme.textTheme.headlineLarge,),
                              TextButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryPage(categories: state.eventCategories)));
                              }, child: Text('See all',style: theme.textTheme.headlineMedium,))
                            ],
                           ),
                           const SizedBox(height: 10,),
                            CategoriesList(categories: state.eventCategories),
                          const SizedBox(height: 20),
                          if (state.trendingEvents.isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Trending Events',style: theme.textTheme.headlineLarge,),
                              Text('See all',style: theme.textTheme.headlineMedium,),
                            ],
                           ),
                           const SizedBox(height: 10,),
                            TrendingEvents(trendingEvents: state.trendingEvents),
                           const SizedBox(height: 20),
                            Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Events at ${widget.userLocation}',style: theme.textTheme.headlineLarge,),
                              Text('See all',style: theme.textTheme.headlineMedium),
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

String getWish(DateTime dateTime) {
  final hour = dateTime.hour;
  if (hour >= 5 && hour < 12) {
    return "Good morning 😊";
  } else if (hour >= 12 && hour < 17) {
    return "Good afternoon ☀️";
  } else {
    return "Good evening 🌇";
  }
}