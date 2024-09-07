import 'package:evento_event_booking/models/event_model.dart';
import 'package:evento_event_booking/resources/constants/image_paths.dart';
import 'package:flutter/material.dart';

class LocationEvents extends StatelessWidget {
  final List<EventModel> eventModel;
  const LocationEvents({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: eventModel.length,
        itemBuilder: (context, index) {
          final EventModel item = eventModel[index];
          return Padding(
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
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(eventModel[index].event_img_1 ?? placeholderImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('10', style: TextStyle(color: Colors.white)),
                                  Text('June', style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black,
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.favorite_rounded, color: Colors.red),
                              padding: EdgeInsets.zero,
                              iconSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.event_name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                  
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
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
          );
        },
      ),
    );
  }
}
