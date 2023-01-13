import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  /// Creates a material design action button.
  const ActionButton({
    super.key,
    this.onPressed,
    required this.child,
    this.color,
    this.closeFabOnTap = true,
  });

  /// The callback that is called when the button is tapped
  final VoidCallback? onPressed;

  /// The widget below this widget in the tree.
  final Widget child;

  /// The background color of the button.
  final Color? color;

  /// Indicates whether the fab should close when the button is tapped.
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
