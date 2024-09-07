import 'package:evento_event_booking/models/event_model.dart';
import 'package:evento_event_booking/resources/constants/image_paths.dart';
import 'package:evento_event_booking/widgets/custom_cachednetwork_image.dart';
import 'package:flutter/material.dart';

class EventTile extends StatelessWidget {
final EventModel eventModel;
const EventTile({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(3),
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
                    imageUrl: eventModel.event_img_1),
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
                        style: theme.textTheme.headline6?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        eventModel.venue ?? 'not available',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyText2?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(Icons.calendar_month, size: 20),
                          const SizedBox(width: 4.0),
                          Text(
                            'hhhbhb',
                            style: theme.textTheme.caption?.copyWith(
                              color: Colors.grey[500],
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
    );
    
  }
}

