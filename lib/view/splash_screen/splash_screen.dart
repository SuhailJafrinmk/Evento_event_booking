import 'package:evento_event_booking/data/shared_preferences/shared_preferences.dart';
import 'package:evento_event_booking/resources/constants/rive_animation_paths.dart';
import 'package:evento_event_booking/resources/constants/text_styles.dart';
import 'package:evento_event_booking/view/home/home_screen.dart';
import 'package:evento_event_booking/view/on_boarding/onboarding_screen_one.dart';
import 'package:evento_event_booking/widgets/zoom_in_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
void initState() {
    super.initState();
    _checkAccessToken();
  }
    Future<void> _checkAccessToken() async {
    await Future.delayed(Duration(seconds: 4)); // Simulate a delay
    String? accessToken = SharedPref.instance.getToken();
    if (accessToken != null && accessToken.isNotEmpty) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnBoardingPage()));
    }
  }
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: ZoomInText(text: 'evento', duration: Duration(seconds: 2)),),
            Align(
              alignment: Alignment.center,
              child: RiveAnimation.asset(
                
                RiveAnimationPaths.splashScreenAnimation
                ),
            ),
          ],
        ),
      ),
    );
  }
}