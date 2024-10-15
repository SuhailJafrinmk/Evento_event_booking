import 'package:evento_event_booking/models/category_model.dart';
import 'package:evento_event_booking/models/event_model.dart';
import 'package:evento_event_booking/widgets/event_tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoryEvents extends StatelessWidget {
  final CategoryModel categoryModel;
  final List<EventModel> eventModel;
  const CategoryEvents({super.key, required this.categoryModel, required this.eventModel});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryModel.name),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: eventModel.length,
          itemBuilder: (context,index){
          final item=eventModel[index];
          return EventTile(eventModel: item);
        }),
      ),
    );
  }
}