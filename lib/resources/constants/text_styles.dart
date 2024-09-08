import 'package:evento_event_booking/resources/constants/user_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles{
  
//textstyle for large headlines style with font monteserrat large
static const TextStyle displayLarge=TextStyle(
  fontSize: 30,
  color: AppColors.textColor,
  fontFamily: 'Montesserat',
  fontWeight: FontWeight.w900,
);

static const TextStyle displayMedium=TextStyle(
  fontFamily: 'Montesserat',
  fontSize: 20,
  fontWeight: FontWeight.w300
);

//montesserat style for boarding screen
static const TextStyle displaySmall=TextStyle(
 fontFamily: 'Montesserat',
 fontSize: 18,
 fontWeight: FontWeight.w200
);

//textstyle for section headers
static const TextStyle headlineLarge=TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: AppColors.cardBackgroundColor,
);

//textstyle for see-all buttton
static const TextStyle headlineMedium=TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: AppColors.cardBackgroundColor
);
//intended for category names eg:
static const TextStyle headlineSmall=TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.bold,
  color: AppColors.cardBackgroundColor
);

//intended for button text eg:button inside carousel
static const TextStyle labelLarge=TextStyle(
  color: AppColors.backgroundColor,
  fontSize: 10,
  fontWeight: FontWeight.bold,
);

//intended for small body texts eg:location events description
static const TextStyle bodySmall=TextStyle(
  fontSize: 12,
  color: Colors.grey,
  fontWeight: FontWeight.w200
);

//intended for medium body 
}