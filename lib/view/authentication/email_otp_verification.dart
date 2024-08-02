import 'package:evento_event_booking/resources/constants/text_styles.dart';
import 'package:evento_event_booking/utils/appthemes.dart';
import 'package:evento_event_booking/widgets/custom_button_black.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class EmailOtpVerification extends StatelessWidget {
  const EmailOtpVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2,
             child: SizedBox()),
            Expanded(
                flex: 6,
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mobile number\nverification',
                          style: montserratLarge,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text('Enter the five digit OTP send to your Email id'),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        OtpTextField(
                          fieldWidth: size.width*.14,
                          keyboardType: TextInputType.number,
                          textStyle: TextStyle(color: Colors.black),
                          filled: true,
                          fillColor: Colors.white,
                          numberOfFields: 6,
                          borderColor: Color(0xFF512DA8),
                          showFieldAsBox: true,
                          onCodeChanged: (String code) {
                            
                          },
                          onSubmit: (String verificationCode) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Verification Code"),
                                    content: Text(
                                        'Code entered is $verificationCode'),
                                  );
                                });
                          }, // end onSubmit
                        ),
                        SizedBox(height: size.height*.02,),
                        CustomButtonBlack(
                          text: 'verify',
                          color: Appthemes.whiteColor,
                          textColor: Appthemes.backgroundColor,
                          width: size.width,
                          )
                      ],
                    ),
                  ),
                )),
            Expanded(flex: 4, child: SizedBox())
          ],
        ),
      ),
    );
  }
}
