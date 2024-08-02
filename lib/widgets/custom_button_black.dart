import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomButtonBlack extends StatelessWidget {
final double ? width;
final Color ? color;
final String text;
final double ? height;
final VoidCallback ? ontap;
final double ? buttonRadius;
final Color ? textColor;
final double ? elevation;

  const CustomButtonBlack
  ({
  super.key,
  required this.text,
  this.buttonRadius,
  this.width,
  this.color,
  this.height,
  this.ontap,
  this.textColor,
  this.elevation
  });


  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return InkWell(
      onTap: ontap,
      child: Card(
        elevation: elevation ?? 10,
        child: Container(
          width: width ?? size.width*.9,
          height: height ?? size.height*.08,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(buttonRadius ?? 10),
            color: color ?? Colors.black,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: textColor ?? Colors.white,
                ),
            ),
          ),
        ),
      ),
    );
  }
}