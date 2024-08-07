import 'package:evento_event_booking/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:evento_event_booking/resources/constants/text_styles.dart';
import 'package:evento_event_booking/utils/appthemes.dart';
import 'package:evento_event_booking/utils/progress_indicator.dart';
import 'package:evento_event_booking/utils/snackbar.dart';
import 'package:evento_event_booking/view/home_screen.dart';
import 'package:evento_event_booking/widgets/custom_button_black.dart';
import 'package:evento_event_booking/widgets/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class EmailOtpVerification extends StatelessWidget {
  final String email;
  String otpCode = '00';
  EmailOtpVerification({super.key, required this.email});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
      if(state is EmailOtpVerified){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
      }else if(state is EmailOtpNotVerified){
        ScaffoldMessenger.of(context).showSnackBar(customSnackbar(context, false,state.errorMessage));
      }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: SizedBox()),
              Expanded(
                  flex: 6,
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email OTP\nverification',
                            style: montserratLarge,
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text(
                              'Enter the six digit OTP send $email'),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CountdownTimerWidget(),
                            ],
                          ),
                            SizedBox(
                            height: size.height * 0.01,
                          ),
                          OtpTextField(
                            contentPadding: const EdgeInsets.all(3),
                            fieldHeight: size.width * .12,
                            fieldWidth: size.width * .12,
                            keyboardType: TextInputType.number,
                            textStyle: TextStyle(color: Colors.black),
                            filled: true,
                            fillColor: Colors.white,
                            numberOfFields: 6,
                            borderColor: Color(0xFF512DA8),
                            showFieldAsBox: true,
                            onCodeChanged: (String code) {},
                            onSubmit: (String verificationCode) {
                              otpCode = verificationCode;
                            }, // end onSubmit
                          ),
                          SizedBox(
                            height: size.height * .02,
                          ),
                          CustomButtonBlack(
                            text: 'verify',
                            color: Colors.cyan,
                            textColor: Appthemes.backgroundColor,
                            width: size.width,
                            ontap: () {
                              if (otpCode.length == 6) {
                                BlocProvider.of<AuthenticationBloc>(context)
                                    .add(VerifyEmailOtp(emailAndOtp: {
                                  "email": email,
                                  "otp": otpCode
                                }));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    customSnackbar(context, false,
                                        'Please check your OTP'));
                              }
                            },
                          ),
                                       SizedBox(
                            height: size.height * .02,
                          ),
                           BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            builder: (context, state) {
                              if(state is VerifyingEmailOtp){
                                return  Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                         
                                    Text('verfiying your otp'),
                                    SizedBox(width: 10,),
                                    CustomProgressIndicator(),
                                  ],
                                );
                              }
                              return SizedBox();
                            },
                          )
                        ],
                      ),
                    ),
                  )),
              Expanded(flex: 4, child: SizedBox())
            ],
          ),
        ),
      ),
    );
  }
}
