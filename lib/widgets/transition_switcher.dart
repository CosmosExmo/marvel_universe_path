import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class CustomTransitionSwitcher extends StatelessWidget {
  final Widget? child;
  final bool reverse;
  final SharedAxisTransitionType transitionType;
  final Duration duration;
  const CustomTransitionSwitcher({
    Key? key,
    this.child,
    this.reverse = false,
    this.transitionType = SharedAxisTransitionType.scaled,
    this.duration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      duration: duration,
      reverse: reverse,
      transitionBuilder: (child, animation, secondaryAnimation) {
        return SharedAxisTransition(
          fillColor: Colors.transparent,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: transitionType,
          child: child,
        );
      },
      child: child,
    );
  }
}
