// import 'package:flutter/material.dart';

// class CustomButtonBlack extends StatefulWidget {
//   final double? width;
//   final Color? color;
//   final String text;
//   final double? height;
//   final VoidCallback? ontap;
//   final double? buttonRadius;
//   final Color? textColor;
//   final double? elevation;
//   final TextStyle? buttonTextStyle;
  
//   CustomButtonBlack({
//     super.key,
//     required this.text,
//     this.buttonRadius,
//     this.width,
//     this.color,
//     this.height,
//     this.ontap,
//     this.textColor,
//     this.elevation,
//     this.buttonTextStyle,
//   });

//   @override
//   State<CustomButtonBlack> createState() => _CustomButtonBlackState();
// }

// class _CustomButtonBlackState extends State<CustomButtonBlack> {
//   late Color buttonColor;

//   @override
//   void initState() {
//     super.initState();
//     buttonColor = widget.color ?? Colors.black;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return InkWell(
//       onTap: () {
//         if (widget.ontap != null) {
//           widget.ontap!();
//         }
//         setState(() {
//           buttonColor = buttonColor.withOpacity(0.6);
//         });
//       },
//       child: Material(
//         elevation: widget.elevation ?? 10,
//         color: widget.color ?? Colors.black,
//         borderRadius: BorderRadius.circular(widget.buttonRadius ?? 10),
//         child: Container(
//           width: widget.width ?? size.width * 0.9,
//           height: widget.height ?? size.height * 0.08,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(widget.buttonRadius ?? 10),
//             color: buttonColor,
//           ),
//           child: Center(
//             child: Text(
//               widget.text,
//               style: widget.buttonTextStyle ?? TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//                 color: widget.textColor ?? Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:evento_event_booking/resources/constants/user_colors.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final double buttonRadius;
  final Color ?color;
  final double elevation;
  final Widget buttonChild;

  const CustomElevatedButton({
    Key? key,
    this.width,
    this.height,
    this.onTap,
    this.buttonRadius = 10.0,
    this.color,
    this.elevation = 10,
    required this.buttonChild
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width * 0.9,
      height: height ?? 50, // Default height
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          enableFeedback: true,
          backgroundColor:color ?? AppColors.accentColor ,
          elevation: elevation,
          padding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
        ),
        child:buttonChild
      ),
    );
  }
}
