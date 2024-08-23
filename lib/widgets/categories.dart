import 'package:cached_network_image/cached_network_image.dart';
import 'package:evento_event_booking/models/category_model.dart';
import 'package:evento_event_booking/resources/constants/text_styles.dart';
import 'package:evento_event_booking/utils/appthemes.dart';
import 'package:evento_event_booking/utils/progress_indicator.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatelessWidget {
  final List<CategoryModel> categories;

  const CategoriesList({required this.categories, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              padding: EdgeInsets.only(bottom: 3),
              width: 80,
              decoration: BoxDecoration(
                color: Appthemes.bottomNavBarColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: categories[index].image,
                        placeholder: (context, url) => CustomProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        width: 40, // Adjust the width if needed
                        height: 40, // Adjust the height if needed
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      categories[index].name,
                      style: bodyText2.copyWith(fontSize: 12),
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



