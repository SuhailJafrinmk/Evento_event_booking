import 'package:evento_event_booking/data/hive/hive_helper.dart';
import 'package:evento_event_booking/data/shared_preferences/shared_preferences.dart';
import 'package:evento_event_booking/resources/constants/rive_animation_paths.dart';
import 'package:evento_event_booking/view/authentication/session_expired_screen.dart';
import 'package:evento_event_booking/view/home/main_navigation_wrapper.dart';
import 'package:evento_event_booking/view/on_boarding/onboarding_screen_one.dart';
import 'package:evento_event_booking/widgets/zoom_in_text.dart';
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
    await Future.delayed(const Duration(seconds: 4)); // Simulate a delay
    String? accessToken = SharedPref.instance.getToken();
    String?refreshToken=SharedPref.instance.getRefreshToken();
    if (accessToken != null && accessToken.isNotEmpty){
      await HiveHelper().storeFavouritesFromBackend();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainNavigationWrapper()));
    }else if(accessToken==null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnBoardingPage()));
    }
     else if (refreshToken ==null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SessionExpiredScreen()));
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
              child: ZoomInText(text: 'evento', duration: const Duration(seconds: 2)),),
            const Align(
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