import 'dart:math';

import 'package:flutter/material.dart';

class ExpandingActionButton extends StatelessWidget {
  /// Creates an expanding action button.
  const ExpandingActionButton({
    super.key,
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
    this.onTap,
  });

  /// The direction of the button's expansion in degrees.
  final double directionInDegrees;

  /// The maximum distance the button should expand.
  final double maxDistance;

  /// The animation that controls the button's expansion progress.
  final Animation<double> progress;

  /// The widget below this widget in the tree.
  final Widget child;

  /// The callback that is called when the button is tapped
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: GestureDetector(
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
