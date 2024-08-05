import 'package:evento_event_booking/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:evento_event_booking/resources/constants/image_paths.dart';
import 'package:evento_event_booking/resources/constants/text_styles.dart';
import 'package:evento_event_booking/resources/constants/user_colors.dart';
import 'package:evento_event_booking/view/authentication/email_login.dart';
import 'package:evento_event_booking/view/authentication/phone_otp_request.dart';
import 'package:evento_event_booking/view/home_screen.dart';
import 'package:evento_event_booking/widgets/login_type_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectAuthentication extends StatelessWidget {
  const SelectAuthentication({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(
      body:SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(padding: EdgeInsets.all(size.width*0),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                child: Stack(
                  children: [
                    SvgPicture.asset(AssetImages.authenticationPageSvg,fit: BoxFit.cover,),
                    SizedBox(
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height*.1,),
                           Text('Login to ',style: montserratMedium,),
                      Text('Join your\nfavourite event',style: montserratLarge,)
                      ],
                     ),
                   ),
                    ),
                  ],
                ),
              )),
               Expanded(
              flex: 2,
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height*0.05,),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MobileOtpRequesting()));
                      },
                      child: Container(
                        height: size.height*.07,
                        width: size.width*.9,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: textColor)
                        ),
                        child: Center(
                          child: Text('Continue with mobile number',style: montserratLarge.copyWith(fontSize: 20),),
                        ),
                      ),
                    ),
                    // SizedBox(height: size.height*0.01,),
                    Text('Or',style: montserratMedium,),
                    LoginTypeContainer(imagePath: AssetImages.googleImageIcon,socialText: 'Login with Google',onTap: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(GoogleSignInClicked());
                    },),
                    LoginTypeContainer(
                      imagePath: AssetImages.emailIconImage,
                      socialText: 'Login with Email',
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EmailLogin()));
                      },
                      ),

              
                  ],
                ),
              ))
          ],
        ),
        ),
        
      ),
    );
  }
}