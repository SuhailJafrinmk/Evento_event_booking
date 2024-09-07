import 'package:evento_event_booking/resources/constants/text_styles.dart';
import 'package:evento_event_booking/resources/constants/user_colors.dart';
import 'package:flutter/material.dart';

class Appthemes{

  static final Color primaryColor = Color(0xFFDDEA38);
  static final Color backgroundColor = Color(0xFF000000);
  static final Color cardColor = Color(0xFF1C1C1C);
  static final Color bottomNavBarColor = Color(0xFF333333);
  static final Color whiteColor = Colors.white;
  static final Color secondaryTextColor = Color(0xFFAAAAAA);

  static final ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundColor,
      iconTheme: IconThemeData(
        color: Colors.white
      )
    ),
    primaryColor: primaryColor,
    backgroundColor: backgroundColor,
    scaffoldBackgroundColor: backgroundColor,
    cardColor: cardColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: bottomNavBarColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: whiteColor,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: whiteColor),
      bodyText1: TextStyle(fontSize: 16, color: whiteColor),
      bodyText2: TextStyle(fontSize: 14, color: secondaryTextColor),
      button: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      buttonColor: primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
        onPrimary: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: primaryColor,
        ),
      ),
      labelStyle: TextStyle(
        color: primaryColor,
      ),
    ),
  );




    
ThemeData themeData=ThemeData(
  useMaterial3: true,
  textTheme: const TextTheme(
    displayLarge: displayLarge,
    displayMedium:displayMedium,
    displaySmall:displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium:headlineMedium,
    headlineSmall: headlineSmall ,
    // bodyLarge: 
    // bodyMedium: 
    bodySmall: bodySmall,
    labelLarge: labelLarge,
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


//textstyle for large headlines style with font monteserrat large
const TextStyle displayLarge=TextStyle(
  fontSize: 30,
  color: AppColors.textColor,
  fontFamily: 'Montesserat',
  fontWeight: FontWeight.w900,
);

const TextStyle displayMedium=TextStyle(
  fontFamily: 'Montesserat',
  fontSize: 20,
  fontWeight: FontWeight.w300
);

//montesserat style for boarding screen
const TextStyle displaySmall=TextStyle(
 fontFamily: 'Montesserat',
 fontSize: 18,
 fontWeight: FontWeight.w200
);

//textstyle for section headers
const TextStyle headlineLarge=TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: AppColors.cardBackgroundColor,
);

//textstyle for see-all buttton
const TextStyle headlineMedium=TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: AppColors.cardBackgroundColor
);
//intended for category names eg:
const TextStyle headlineSmall=TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.bold,
  color: AppColors.cardBackgroundColor
);

//intended for button text eg:button inside carousel
const TextStyle labelLarge=TextStyle(
  color: AppColors.backgroundColor,
  fontSize: 10,
  fontWeight: FontWeight.bold,
);

//intended for small body texts eg:location events description
const TextStyle bodySmall=TextStyle(
  fontSize: 12,
  color: Colors.grey,
  fontWeight: FontWeight.w200
);

//intended for medium body 