import 'package:evento_event_booking/models/event_model.dart';
import 'package:evento_event_booking/resources/api_urls/api_urls.dart';
import 'package:evento_event_booking/resources/constants/image_paths.dart';
import 'package:evento_event_booking/resources/constants/user_colors.dart';
import 'package:evento_event_booking/view/events/single_event.dart';
import 'package:evento_event_booking/widgets/custom_cachednetwork_image.dart';
import 'package:flutter/material.dart';

class EventTile extends StatelessWidget {
final EventModel eventModel;
const EventTile({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    String imageUrl = eventModel.event_img_1!.contains(ApiUrls.baseUrl)
        ? eventModel.event_img_1 ?? placeholderImage
        : '${ApiUrls.baseUrl}${eventModel.event_img_1}';
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>EventDetailsScreen(eventModel: eventModel,)));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CustomCachedNetworkImage(
                      height: screenWidth*0.25,
                      width: screenWidth*.25,
                      imageUrl: imageUrl),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          eventModel.event_name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.headlineLarge?.copyWith(
                            color: AppColors.backgroundColor,
                            // fontSize: 14
                            ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          '${eventModel.location}\n${eventModel.venue}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.bottomNavBarColor,
                            fontSize: 14
                            ),
                        ),
                        // const SizedBox(height: 8.0),
                        Row(
                          children: [
                            Icon(Icons.calendar_month, size: 20),
                            const SizedBox(width: 4.0),
                            Text(
                            eventModel.end_date,
                            style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.bottomNavBarColor,
                            fontSize: 14
                            ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
    
  }
}

