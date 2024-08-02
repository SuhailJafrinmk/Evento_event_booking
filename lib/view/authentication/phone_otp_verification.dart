import 'package:evento_event_booking/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:evento_event_booking/resources/constants/text_styles.dart';
import 'package:evento_event_booking/utils/app/validations.dart';
import 'package:evento_event_booking/utils/appthemes.dart';
import 'package:evento_event_booking/utils/snackbar.dart';
import 'package:evento_event_booking/widgets/custom_button_black.dart';
import 'package:evento_event_booking/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MobileOtpVerification extends StatefulWidget {
  @override
  State<MobileOtpVerification> createState() => _MobileOtpVerificationState();
}

class _MobileOtpVerificationState extends State<MobileOtpVerification> {
  final TextEditingController mobileNumberContoller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Form(
          key: formkey,
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
                          style: montserratLarge,
                        ),
                        SizedBox(
                          height: size.width * .04,
                        ),
                        Text('Enter your number to send an otp'),
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
                        CustomButtonBlack(
                          ontap: () {
                            if (formkey.currentState!.validate()) {
                              BlocProvider.of<AuthenticationBloc>(context).add(
                                  RequestMobileOtp(mobileNumber: {
                                "phone_number": "+91 ${mobileNumberContoller.text}"
                              }));
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(customSnackbar(context, false, 'form not valid'));
                            }
                          },
                          width: size.width,
                          text: 'Send otp to verify',
                          color: Appthemes.whiteColor,
                          textColor: Appthemes.backgroundColor,
                        ),
                      ],
                    ),
                  )),
              Expanded(flex: 5, child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}
