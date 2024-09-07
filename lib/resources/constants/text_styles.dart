import 'package:evento_event_booking/resources/constants/user_colors.dart';
import 'package:flutter/material.dart';


//authentication pages
TextStyle montserratLarge=TextStyle(
  fontSize: 30,
  color: AppColors.textColor,
  fontFamily: 'Montesserat',
  fontWeight: FontWeight.w900,
);
TextStyle montserratMedium=montserratLarge.copyWith(
  fontSize: 20,
  fontWeight: FontWeight.w300
);
TextStyle unimportantTextWhite=TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w300,
  color: AppColors.categoryBackgroundColor,
);



  // Headline Styles
   const TextStyle headline1 = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  const TextStyle headline2 = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

   const TextStyle headline3 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  // Subtitle Styles
   const TextStyle subtitle1 = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: Colors.black54,
  );

   const TextStyle subtitle2 = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: Colors.black54,
  );

  // Body Text Styles
   const TextStyle bodyText1 = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

   const TextStyle bodyText2 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // Caption Style
   const TextStyle caption = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: Colors.grey,
  );

  // Button Text Style
   const TextStyle button = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  // Overline Style
  const TextStyle overline = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w400,
    color: Colors.black54,
  );


// import 'package:flutter/material.dart';

// class AppTextStyles {
//   // Large headline for the greeting (e.g., Hey Guest, Good afternoon)
//   static const TextStyle headline1 = TextStyle(
//     fontSize: 36, // Adjust according to what looks closer
//     fontWeight: FontWeight.bold,
//     color: Colors.white, // Since the background is dark
//   );

//   // Medium headline for location (e.g., Kozhikkode)
//   static const TextStyle headline2 = TextStyle(
//     fontSize: 20,
//     fontWeight: FontWeight.normal,
//     color: Colors.white54, // Lighter color for secondary text
//   );

//   // TextStyle for event titles (e.g., Marathon D-24-2 Malappuram)
//   static const TextStyle eventTitle = TextStyle(
//     fontSize: 18,
//     fontWeight: FontWeight.bold,
//     color: Colors.white,
//   );

//   // Button text style (e.g., Book Now)
//   static const TextStyle buttonText = TextStyle(
//     fontSize: 16,
//     fontWeight: FontWeight.bold,
//     color: Colors.black, // For contrast with the yellow button background
//   );

//   // Category section heading (e.g., Categories, Trending Events)
//   static const TextStyle sectionHeading = TextStyle(
//     fontSize: 22,
//     fontWeight: FontWeight.bold,
//     color: Colors.white,
//   );

//   // "See all" style
//   static const TextStyle seeAll = TextStyle(
//     fontSize: 16,
//     fontWeight: FontWeight.w500,
//     color: Colors.white54, // To make it look less important
//   );

//   // Trending event description (e.g., Mountain Trekking)
//   static const TextStyle eventDescription = TextStyle(
//     fontSize: 16,
//     fontWeight: FontWeight.w600,
//     color: Colors.white,
//   );

//   // Date and location text style (smaller secondary text)
//   static const TextStyle eventDateLocation = TextStyle(
//     fontSize: 14,
//     fontWeight: FontWeight.w400,
//     color: Colors.white70, // Lighter than eventDescription
//   );
// }
