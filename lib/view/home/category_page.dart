import 'package:evento_event_booking/models/category_model.dart';
import 'package:evento_event_booking/models/event_model.dart';
import 'package:evento_event_booking/widgets/category_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  final List<CategoryModel> categories;
  const CategoryPage({super.key, required this.categories});
  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return  Scaffold(
      appBar: AppBar(
        title: Text('All categories',style: theme.textTheme.headlineLarge,),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final item=categories[index];
                 return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: CategoryCard(categoryModel: item),
            );
          },
          ),
      ),
    );
  }
}