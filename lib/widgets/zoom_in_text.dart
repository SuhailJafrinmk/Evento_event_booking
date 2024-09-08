import 'package:evento_event_booking/resources/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ZoomInText extends StatefulWidget {
  final String text;
  final Duration duration;
  

  ZoomInText({required this.text,required this.duration});

  @override
  State<ZoomInText> createState() => _ZoomInTextState();
}

class _ZoomInTextState extends State<ZoomInText> {
  bool isVisible=false;
  @override
  void initState() {
    super.initState();
    _showWidgetAfterDelay();
  }
   void _showWidgetAfterDelay() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      isVisible = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return isVisible==true ? 
    TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: widget.duration,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Text(
            widget.text,
            style: theme.textTheme.displayLarge?.copyWith(fontSize:40),
          ),
        );
      },
    ) : SizedBox();
  }
}