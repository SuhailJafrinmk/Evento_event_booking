import 'package:evento_event_booking/resources/constants/text_styles.dart';
import 'package:evento_event_booking/resources/constants/user_colors.dart';
import 'package:flutter/material.dart';

class Appthemes{
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
      iconTheme: IconThemeData(
        color: AppColors.textColor
      )
    ),
    scaffoldBackgroundColor: AppColors.backgroundColor,
    cardColor: AppColors.cardBackgroundColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.backgroundColor,
      selectedItemColor: AppColors.accentColor,
      unselectedItemColor: AppColors.textColor,
    ),
    textTheme: const TextTheme(
    displayLarge: AppTextStyles.displayLarge,
    displayMedium:AppTextStyles.displayMedium,
    displaySmall:AppTextStyles.displaySmall,
    headlineLarge: AppTextStyles.headlineLarge,
    headlineMedium:AppTextStyles.headlineMedium,
    headlineSmall: AppTextStyles.headlineSmall ,
    // bodyLarge: 
    // bodyMedium: 
    bodySmall: AppTextStyles.bodySmall,
    labelLarge: AppTextStyles.labelLarge,
    // labelMedium: 
    // labelSmall: 
    // bodyLarge: 
  ),
 
  );




}

// ThemeData themeData=ThemeData(
//   useMaterial3: true,
//   textTheme: const TextTheme(
//     displayLarge: displayLarge,
//     displayMedium:displayMedium,
//     displaySmall:
//     headlineLarge: 
//     headlineMedium:
//     headlineSmall: 
//     titleLarge: 
//     titleMedium: 
//     titleSmall: 
//     bodyLarge: 
//     bodyMedium: 
//     bodySmall: 
//     labelLarge: 
//     labelMedium: 
//     labelSmall: 
//     bodyLarge: 
//   ),
// );

