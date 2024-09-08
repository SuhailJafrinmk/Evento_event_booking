import 'package:evento_event_booking/resources/constants/user_colors.dart';
import 'package:flutter/material.dart';

class PillContainer extends StatelessWidget {
  final double ? height;
  final double  ?width;
  final Color ? color;
  final double ? radius;
  final double ? padding;
  final Widget  child;
  const PillContainer({super.key, this.height, this.width, this.color, this.radius, this.padding, required this.child});

  Widget build(BuildContext context) {
    return Container(
      height: height ?? 40,
      width: width ?? 150,
      decoration: BoxDecoration(
        color: color ?? AppColors.textColor,
        borderRadius: BorderRadius.circular(radius ?? 30),
      ),
      padding: EdgeInsets.all(padding ?? 5),
      child: child,
    );
  }
}