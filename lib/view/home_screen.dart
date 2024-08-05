import 'package:evento_event_booking/data/shared_preferences/shared_preferences.dart';
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
    return  Scaffold(
      
    );
  }
}