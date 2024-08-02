import 'package:evento_event_booking/resources/constants/text_styles.dart';
import 'package:evento_event_booking/resources/constants/user_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginTypeContainer extends StatelessWidget {
final String socialText;
final String imagePath;
VoidCallback ? onTap;

   LoginTypeContainer({super.key, required this.socialText,required this.imagePath,this.onTap});

  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        height: size.height*.08,
        width: size.width*.9,
        decoration: BoxDecoration(
          color: textColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath),
            SizedBox(width: 10,),
            Text(socialText,style: montserratMedium.copyWith(color: backgroundColor,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}