import 'dart:math';
import 'package:evento_event_booking/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:evento_event_booking/development_only/custom_logger.dart';
import 'package:evento_event_booking/resources/constants/text_styles.dart';
import 'package:evento_event_booking/utils/app/validations.dart';
import 'package:evento_event_booking/utils/appthemes.dart';
import 'package:evento_event_booking/utils/snackbar.dart';
import 'package:evento_event_booking/view/authentication/email_otp_verification.dart';
import 'package:evento_event_booking/view/home/home_screen.dart';
import 'package:evento_event_booking/widgets/custom_button_black.dart';
import 'package:evento_event_booking/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

class EmailLogin extends StatefulWidget {
  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        developer.log('state of email login page is $state');
        if(state is RequestingEmailOtp){
         ScaffoldMessenger.of(context).showSnackBar(customSnackbar(context, true, 'Otp send to your registered email id'));
        }else if(state is EmailOtpRequested){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>EmailOtpVerification(email: emailController.text,)));
        }else if(state is ErrorSendingEmailOtp){
          logError('error sending email otp : ${state.errorMessage}');
          ScaffoldMessenger.of(context).showSnackBar(customSnackbar(context, false, state.errorMessage));
        }
      },
      child: Scaffold(
        body: SizedBox(
          child: SafeArea(
            child: Form(
              key: formkey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                        flex: 3,
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Login',
                                style: montserratLarge,
                              ),
                              Text('Please Login to your account'),
                              SizedBox(
                                height: size.height * .02,
                              ),
                              CustomTextField(
                                  validator: (value) =>
                                      Validations.emailValidation(value),
                                  prefixIcon: Icons.email,
                                  inputType: TextInputType.emailAddress,
                                  hintText: 'Email',
                                  textEditingController: emailController),
                              SizedBox(
                                height: size.height * .02,
                              ),
                              Row(
                                children: [
                                  Expanded(child: SizedBox()),
                                  CustomButtonBlack(
                                    ontap: () {
                                      if (formkey.currentState!.validate()) {
                                        BlocProvider.of<AuthenticationBloc>(
                                                context)
                                            .add(RequestEmailOtp(UserEmail: {
                                          'email': emailController.text
                                        }));
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(customSnackbar(context, false, 'Invalid credentials'));
                                      }
                                    },
                                    elevation: 20,
                                    width: size.width*.94,
                                    text: 'Sign in',
                                    color: Appthemes.primaryColor,
                                    textColor: Appthemes.backgroundColor,
                                  ),
                               
                                ],
                              ),
                            
                                 BlocBuilder<AuthenticationBloc, AuthenticationState>(
                                    builder: (context, state) {
                                      if(state is RequestingEmailOtp){
                                        return Text('Please wait for a second...');
                                      }
                                      return SizedBox();
                                    },
                                  )
                            ],
                          ),
                        )),
                    Expanded(flex: 1, child: SizedBox()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
