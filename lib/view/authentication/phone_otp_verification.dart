import 'package:evento_event_booking/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:evento_event_booking/development_only/custom_logger.dart';
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

class phoneOtpVerification extends StatelessWidget {
  final String phoneNumber;
  String otpCode='00';

  phoneOtpVerification({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if(state is MobileNumberOtpNotVerified){
          logError('listener is listenting to $state');
          ScaffoldMessenger.of(context).showSnackBar(customSnackbar(context, false, state.errorMessage));
        }else if(state is MobileNumberOtpVerified){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
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
              const Expanded(flex: 2, child: SizedBox()),
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
                           Text(
                              'Enter the six digit OTP send to +91 ${phoneNumber}'),
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
                            textStyle: const TextStyle(color: Colors.black),
                            filled: true,
                            fillColor: Colors.white,
                            numberOfFields: 6,
                            borderColor: const Color(0xFF512DA8),
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
                                    .add(VerifyMobileOtp(mobileAndOtp: {
                                  "phone_number": "+91$phoneNumber",
                                  "otp": otpCode
                                }));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    customSnackbar(context, false,
                                        'Please check your OTP'));
                              }
                            },
                          ),
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            builder: (context, state) {
                              if(state is VerfiyingMobileOtp){
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('verfiying your otp'),
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
              const Expanded(flex: 4, child: SizedBox())
            ],
          ),
        ),
      ),
    );
  }
}
