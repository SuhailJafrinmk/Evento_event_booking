import 'package:evento_event_booking/development_only/custom_logger.dart';
import 'package:evento_event_booking/resources/api_urls/api_urls.dart';
import 'package:evento_event_booking/resources/constants/image_paths.dart';
import 'package:evento_event_booking/resources/constants/text_styles.dart';
import 'package:evento_event_booking/resources/constants/user_colors.dart';
import 'package:evento_event_booking/utils/appthemes.dart';
import 'package:evento_event_booking/utils/cache_manager.dart';
import 'package:evento_event_booking/view/events/single_event.dart';
import 'package:evento_event_booking/widgets/custom_button_black.dart';
import 'package:evento_event_booking/widgets/custom_cachednetwork_image.dart';
import 'package:flutter/material.dart';
import 'package:evento_event_booking/models/event_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TrendingEvents extends StatelessWidget {
  final List<EventModel> trendingEvents;
  const TrendingEvents({required this.trendingEvents, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final theme=Theme.of(context);
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: trendingEvents.length,
        itemBuilder: (context, index) {
          final event = trendingEvents[index];
          logInfo('image link is ${event.event_img_1}');
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              width: size.width * .9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white12),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(event.event_name,style: theme.textTheme.headlineSmall,),
                                Text(event.end_date,style: theme.textTheme.headlineSmall),
                              ],
                            ),
                          ),
                          CustomButtonBlack(
                            elevation: 20,
                            color: AppColors.accentColor,
                            width: 70,
                            height: 30,
                            text: 'Book now',
                            buttonTextStyle: theme.textTheme.labelLarge,
                            ontap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>EventDetailsScreen(eventModel: event)));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      child: CustomCachedNetworkImage(imageUrl: '${ApiUrls.baseUrl}${event.event_img_1}')
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


// import 'package:evento_event_booking/development_only/custom_logger.dart';
// import 'package:evento_event_booking/resources/api_urls/api_urls.dart';
// import 'package:evento_event_booking/resources/constants/image_paths.dart';
// import 'package:evento_event_booking/resources/constants/text_styles.dart';
// import 'package:evento_event_booking/utils/appthemes.dart';
// import 'package:evento_event_booking/widgets/custom_button_black.dart';
// import 'package:flutter/material.dart';
// import 'package:evento_event_booking/models/event_model.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// class TrendingEvents extends StatelessWidget {
//   final List<EventModel> trendingEvents;
//   const TrendingEvents({required this.trendingEvents, Key? key}) : super(key: key);
  
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
    
//     return SizedBox(
//       height: 150,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: trendingEvents.length,
//         itemBuilder: (context, index) {
//           final event = trendingEvents[index];
          
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 5),
//             child: Container(
//               width: size.width * .9,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: Colors.white12),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       decoration: const BoxDecoration(
//                         color: Colors.white30,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(10),
//                           bottomLeft: Radius.circular(10),
//                         ),
//                       ),
//                       padding: const EdgeInsets.all(10),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(event.event_name),
//                               Text(event.end_date),
//                             ],
//                           ),
//                           CustomButtonBlack(
//                             elevation: 20,
//                             color: Appthemes.primaryColor,
//                             width: 70,
//                             height: 30,
//                             text: 'Book now',
//                             buttonTextStyle: button.copyWith(fontSize: 10),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: const BorderRadius.only(
//                           topRight: Radius.circular(10),
//                           bottomRight: Radius.circular(10),
//                         ),
//                       ),
//                       child: CachedNetworkImage(
//                         imageUrl: '${ApiUrls.baseUrl}${event.event_img_1}' ?? placeholderImage,
//                         fit: BoxFit.cover,
//                         placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
//                         errorWidget: (context, url, error) => const Icon(Icons.error),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

