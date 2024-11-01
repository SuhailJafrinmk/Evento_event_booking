import 'package:evento_event_booking/resources/constants/user_colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomProgressIndicator extends StatelessWidget {
  final Color ? color;
  final double ? size;

  const CustomProgressIndicator({super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.threeArchedCircle(
      color: color ?? AppColors.accentColor,
       size: size ?? 20,
       );
  }
}