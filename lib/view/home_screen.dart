import 'package:evento_event_booking/data/shared_preferences/shared_preferences.dart';
import 'package:evento_event_booking/development_only/custom_logger.dart';
import 'package:evento_event_booking/widgets/custom_button_black.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 final String ?token=SharedPref.instance.getToken();
  @override
  void initState() {
    final token=SharedPref.instance.getToken();
    developer.log('the token is $token');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return  Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: CustomButtonBlack(
          color: Colors.red,
          text: 'delete tokens',
          ontap: () {
            SharedPref.instance.removeToken();
            logError('token deleted');
            Navigator.pop(context);
          },
          ),
      ),
    );
  }
}