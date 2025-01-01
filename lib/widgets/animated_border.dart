import 'package:evento_event_booking/resources/constants/user_colors.dart';
import 'package:flutter/material.dart';

class AnimatedBorderContainer extends StatefulWidget {
  final double ? radius; // Radius of the CircleAvatar or any child widget
  final Widget  child; // Child widget to be placed inside, not restricted to CircleAvatar
  final Duration ? duration; // Duration of the animation
  final Color ? borderColor; // Border color
  final double ? borderWidth; // Border width
  final EdgeInsets ?padding; // Padding around the child widget
  final Gradient ?gradient; // Gradient to animate around the border

   AnimatedBorderContainer({
    Key? key,
    required this.radius,
    required this.child,
    this.duration = const Duration(seconds: 10),
    this.borderColor = Colors.white,
    this.borderWidth = 2.0,
    this.padding = const EdgeInsets.all(3.0),
    Gradient? gradient,
  })  : this.gradient = gradient ??
            SweepGradient(
              colors: [Colors.white, Colors.transparent],
              stops: [0.5, 0.5],
            ),
        super(key: key);

  @override
  _AnimatedBorderContainerState createState() =>
      _AnimatedBorderContainerState();
}

class _AnimatedBorderContainerState extends State<AnimatedBorderContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _borderAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(); // Continuous rotation

    // Define the border animation (rotates from 0 to 360 degrees)
    _borderAnimation = Tween<double>(begin: 0.0, end: 360.0).animate(_controller);
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is removed from the widget tree
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _borderAnimation,
      builder: (context, child) {
        return Container(
          padding: widget.padding,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: widget.borderColor ?? AppColors.accentColor,
              width: widget.borderWidth ?? 1,
            ),
            gradient: widget.gradient,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: widget.gradient?.colors ?? [Colors.white,AppColors.accentColor],
                stops: widget.gradient?.stops ?? [0.5,0.5],
                transform: GradientRotation(_borderAnimation.value * 0.0174533), // Convert degrees to radians
              ),
            ),
            child: widget.child,
          ),
        );
      },
    );
  }
}
