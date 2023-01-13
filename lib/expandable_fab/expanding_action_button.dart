import 'dart:math';

import 'package:flutter/material.dart';

class ExpandingActionButton extends StatelessWidget {
  const ExpandingActionButton({
    super.key,
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
    this.onTap,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;
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
