import 'package:evento_event_booking/models/category_model.dart';
import 'package:evento_event_booking/models/event_model.dart';
import 'package:evento_event_booking/resources/constants/user_colors.dart';
import 'package:evento_event_booking/widgets/custom_button_black.dart';
import 'package:evento_event_booking/widgets/custom_cachednetwork_image.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel categoryModel;
  const CategoryCard({super.key, required this.categoryModel});
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    final theme=Theme.of(context);
       return Container(
      width: size.width*.95,
      height: size.height*.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                SizedBox(height: 5,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CustomCachedNetworkImage(
                    height: size.height*.7,
                    width: size.width*.93,
                    imageUrl: categoryModel.image,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 80,
            left: 16,
            child: Text(
              categoryModel.name,
              style: theme.textTheme.displayLarge?.copyWith(color: AppColors.backgroundColor),

            ),
          ),
          Positioned(
            bottom: 20,
            left: 16,
            child: CustomButtonBlack(
              width: 100,
              height: 40,
              color: AppColors.accentColor,
              text: 'Explore',
              buttonTextStyle: theme.textTheme.labelLarge?.copyWith(fontSize: 13),
              ),
          ),
        ],
      ),
    );
 
  }
}