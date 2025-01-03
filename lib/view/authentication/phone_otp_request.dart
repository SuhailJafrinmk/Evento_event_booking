import 'package:evento_event_booking/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:evento_event_booking/blocs/timer_cubit/timer_cubit.dart';
import 'package:evento_event_booking/utils/app/validations.dart';
import 'package:evento_event_booking/utils/progress_indicator.dart';
import 'package:evento_event_booking/utils/snackbar.dart';
import 'package:evento_event_booking/view/authentication/phone_otp_verification.dart';
import 'package:evento_event_booking/widgets/custom_button_black.dart';
import 'package:evento_event_booking/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:developer' as developer;

class MobileOtpRequesting extends StatefulWidget {
  @override
  State<MobileOtpRequesting> createState() => _MobileOtpVerificationState();
}

class _MobileOtpVerificationState extends State<MobileOtpRequesting> {
  final TextEditingController mobileNumberContoller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final theme=Theme.of(context);
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        developer.log('the current state of the application is $state');
        if(state is RequestingMobileOtp){
          ScaffoldMessenger.of(context).showSnackBar(customSnackbar(context, true, 'An otp have been sent to your number'));
        }else if(state is MobileOtpRequested){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>phoneOtpVerification(phoneNumber: mobileNumberContoller.text,)));
        }else if(state is ErrorSendingMobileOtp){
        ScaffoldMessenger.of(context).showSnackBar(customSnackbar(context, false, '${state.errorMessage}'));

        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                      flex: 5,
                      child: SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mobile Number\nVerification',
                              style: theme.textTheme.displayLarge,
                            ),
                            SizedBox(
                              height: size.width * .04,
                            ),
                            Text('Enter your number to send an otp',style: theme.textTheme.headlineLarge,),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            CustomTextField(
                                prefixText: '+91 ',
                                inputType: TextInputType.number,
                                validator: (value) =>
                                    Validations.phoneNumberValidate(value),
                                prefixIcon: FontAwesomeIcons.mobileScreen,
                                hintText: 'Mobile number',
                                textEditingController: mobileNumberContoller),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            CustomElevatedButton(
                               width: size.width,
                              buttonChild: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                                builder: (context, state) {
                                  if(state is RequestingMobileOtp){
                                    return CustomProgressIndicator(color: Colors.black,size: 30,);
                                  }
                                  return Text('Send otp to verify');
                                },
                              ),
                                onTap: () {
                                if (formkey.currentState!.validate()) {
                                 context.read<TimerCubit>().startTimer();
                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .add(RequestMobileOtp(mobileNumber: {
                                    "phone_number":
                                        "+91${mobileNumberContoller.text}"
                                  }));

                              

                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      customSnackbar(
                                          context, false, 'Entered phone number is not valid or empty'));
                                }
                              },
                              ),
                            // CustomButtonBlack(
                            //   ontap: () {
                            //     if (formkey.currentState!.validate()) {
                            //       BlocProvider.of<AuthenticationBloc>(context)
                            //           .add(RequestMobileOtp(mobileNumber: {
                            //         "phone_number":
                            //             "+91${mobileNumberContoller.text}"
                            //       }));
                            //     } else {
                            //       ScaffoldMessenger.of(context).showSnackBar(
                            //           customSnackbar(
                            //               context, false, 'Entered phone number is not valid or empty'));
                            //     }
                            //   },
                            //   width: size.width,
                            //   text: 'Send otp to verify',
                            //   color: AppColors.accentColor,
                            //   textColor: AppColors.backgroundColor,
                            // ),
                                    BlocBuilder<AuthenticationBloc, AuthenticationState>(
                                    builder: (context, state) {
                                      if(state is RequestingMobileOtp){
                                        return Text('Please wait for a second...');
                                      }
                                      return SizedBox();
                                    },
                                  )
                          ],
                        ),
                      )),
                  Expanded(flex: 5, child: SizedBox()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
