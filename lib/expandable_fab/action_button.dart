import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.onPressed,
    required this.child,
    this.color,
    this.closeFabOnTap = true,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final Color? color;

  // this variable will be accessed and used by [ExpandableFab] widget
  final bool closeFabOnTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: color ?? theme.colorScheme.secondary,
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: child,
      ),
    );
  }
}
