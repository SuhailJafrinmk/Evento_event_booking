
import 'package:evento_event_booking/resources/constants/image_paths.dart';
import 'package:evento_event_booking/resources/constants/text_styles.dart';
import 'package:evento_event_booking/resources/constants/user_colors.dart';
import 'package:evento_event_booking/view/authentication/select_authentication_type.dart';
import 'package:evento_event_booking/widgets/custom_button_black.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          OnboardingScreen(
            imagePath: AssetImages.onboardingImgOne,
            title: 'Grab all events now in your hands',
            description: 'Evento is here to help you find the best events.',
          ),
          OnboardingScreen(
            imagePath: AssetImages.onboardingImgTwo,
            title: 'Easy payment and booking',
            description: 'Evento helps you find and book events easily and quickly.',
          ),
          OnboardingScreen(
            imagePath: AssetImages.onboardingImgThree,
            title: 'Let\'s go get your favourite event',
            description: 'Start exploring events and make your bookings now.',
          ),
        ],
      ),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  OnboardingScreen({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    final theme=Theme.of(context);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.all(20),
            height: size.height*.5,
            width: size.width,
            color: Colors.white.withOpacity(0.5),
            child: Column(
              children: [
                Text(title,style:theme.textTheme.displayLarge?.copyWith(color: AppColors.backgroundColor)),
                SizedBox(height: 10,),
                Text(description,style: theme.textTheme.headlineLarge?.copyWith(color: AppColors.backgroundColor)),
                SizedBox(height: size.height*.15,),
                CustomButtonBlack(text: 'Next',ontap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SelectAuthentication()));
                },),
              ],
            ),
          ),
        ),
      ],
    );
  }
}