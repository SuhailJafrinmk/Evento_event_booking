import 'package:cached_network_image/cached_network_image.dart';
import 'package:evento_event_booking/models/category_model.dart';
import 'package:evento_event_booking/resources/constants/text_styles.dart';
import 'package:evento_event_booking/resources/constants/user_colors.dart';
import 'package:evento_event_booking/utils/appthemes.dart';
import 'package:evento_event_booking/utils/cache_manager.dart';
import 'package:evento_event_booking/utils/progress_indicator.dart';
import 'package:evento_event_booking/widgets/custom_cachednetwork_image.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatelessWidget {
  final List<CategoryModel> categories;

  const CategoriesList({required this.categories, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Container(
      height: 60.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final item=categories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              padding: EdgeInsets.only(bottom: 3),
              width: 80,
              decoration: BoxDecoration(
                color: AppColors.categoryBackgroundColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: ClipOval(
                      child: CustomCachedNetworkImage(
                        width: 40,
                        height: 40,
                        imageUrl: item.image
                        ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      categories[index].name,
                      style: theme.textTheme.headlineSmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
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



