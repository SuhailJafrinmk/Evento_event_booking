
// import 'package:evento_event_booking/blocs/event/bloc/event_bloc.dart';
// import 'package:evento_event_booking/data/shared_preferences/shared_preferences.dart';
// import 'package:evento_event_booking/development_only/custom_logger.dart';
// import 'package:evento_event_booking/resources/constants/image_paths.dart';
// import 'package:evento_event_booking/resources/constants/text_styles.dart';
// import 'package:evento_event_booking/widgets/bottom_navigation_bar.dart';
// import 'package:evento_event_booking/widgets/carousel_widget.dart';
// import 'package:evento_event_booking/widgets/categories.dart';
// import 'package:evento_event_booking/widgets/custom_button_black.dart';
// import 'package:evento_event_booking/widgets/trending_events.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class HomePage extends StatefulWidget {
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
// class _HomePageState extends State<HomePage> {
//   final String? token = SharedPref.instance.getToken();
// @override
//   void initState() {
//     super.initState();
//         context.read<EventBloc>()
//       ..add(FetchEventCategories())
//       ..add(FetchTrendingEvents())
//       ..add(FetchAllEvents());
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     final String? name = SharedPref.instance.getUserName() ?? "Guest";
//     final String? userLocation = SharedPref.instance.getUserLocation() ?? 'Unavailable';

//     return Scaffold(
//       bottomNavigationBar: CustomNavigationBar(),
//       appBar: AppBar(
//         leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
//         centerTitle: true,
//         title: Text(userLocation ?? '', style: montserratMedium),
//         actions: [
//           CircleAvatar(
//             radius: size.width * .05,
//             backgroundColor: Colors.white,
//           ),
//           SizedBox(width: size.width * .05),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Hey $name\nGood afternoon', style: montserratLarge),
//             SizedBox(height: 20),
//             BlocBuilder<EventBloc, EventState>(
//               builder: (context, state) {
//                 logInfo('the current state of the application is $state');
//                 if (state is EventStateLoaded) {
//                   // Handle loading, error, and successful data fetching cases
//                   if (state.isLoading) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (state.errorMessage != null) {
//                     return Text(
//                       'Failed to load data: ${state.errorMessage}',
//                       style: TextStyle(color: Colors.red),
//                     );
//                   }

//                   return Column(
//                     children: [
//                       // Event Carousel
//                       if (state.allEvents.isNotEmpty)
//                         EventCarousel(eventImages: state.allEvents,),
//                       SizedBox(height: 20),

//                       // Categories List
//                       if (state.eventCategories.isNotEmpty)
//                        Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Categories',style: bodyText2.copyWith(fontSize: 16),),
//                           Text('See all',style: bodyText2.copyWith(fontSize: 16),),
//                         ],
//                        ),
//                        SizedBox(height: 10,),
//                         CategoriesList(categories: state.eventCategories),
//                       SizedBox(height: 20),
//                       // Trending Events List
//                       if (state.trendingEvents.isNotEmpty)
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Trending Events',style: bodyText2.copyWith(fontSize: 16),),
//                           Text('See all',style: bodyText2.copyWith(fontSize: 16),),
//                         ],
//                        ),
//                         TrendingEvents(trendingEvents: state.trendingEvents),
//                     ],
//                   );
//                 }
//                 return Center(child: CircularProgressIndicator());
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:evento_event_booking/blocs/event/bloc/event_bloc.dart';
import 'package:evento_event_booking/development_only/custom_logger.dart';
import 'package:evento_event_booking/resources/constants/text_styles.dart';
import 'package:evento_event_booking/widgets/carousel_widget.dart';
import 'package:evento_event_booking/widgets/categories.dart';
import 'package:evento_event_booking/widgets/trending_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  final String userName;
  HomePage({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hey $userName\nGood afternoon', style: montserratLarge),
            SizedBox(height: 20),
            BlocBuilder<EventBloc, EventState>(
              builder: (context, state) {
                logInfo('the current state of the application is $state');
                if (state is EventStateLoaded) {
                  // Handle loading, error, and successful data fetching cases
                  if (state.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state.errorMessage != null) {
                    return Text(
                      'Failed to load data: ${state.errorMessage}',
                      style: TextStyle(color: Colors.red),
                    );
                  }

                  return Column(
                    children: [
                      // Event Carousel
                      if (state.allEvents.isNotEmpty)
                        EventCarousel(eventImages: state.allEvents,),
                      SizedBox(height: 20),

                      // Categories List
                      if (state.eventCategories.isNotEmpty)
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Categories',style: bodyText2.copyWith(fontSize: 16),),
                          Text('See all',style: bodyText2.copyWith(fontSize: 16),),
                        ],
                       ),
                       SizedBox(height: 10,),
                        CategoriesList(categories: state.eventCategories),
                      SizedBox(height: 20),
                      // Trending Events List
                      if (state.trendingEvents.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Trending Events',style: bodyText2.copyWith(fontSize: 16),),
                          Text('See all',style: bodyText2.copyWith(fontSize: 16),),
                        ],
                       ),
                        TrendingEvents(trendingEvents: state.trendingEvents),
                    ],
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      );
  }
}