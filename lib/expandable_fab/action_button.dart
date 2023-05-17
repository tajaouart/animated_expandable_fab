import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  /// Creates a material design action button.
  const ActionButton({
    super.key,
    this.onPressed,
    required this.child,
    this.color,
    this.closeFabOnTap = true,
    this.padding = const EdgeInsets.all(12.0),
    this.text,
    this.elevation = 4.0,
    this.textGap = 6.0,
    this.textStyle
  });

  /// The callback that is called when the button is tapped
  final VoidCallback? onPressed;

  /// The widget below this widget in the tree.
  final Widget child;

  /// The background color of the button.
  final Color? color;

  /// Indicates whether the fab should close when the button is tapped.
  final bool closeFabOnTap;

  // The padding of the button
  final EdgeInsets padding;

  // The elevation of the button
  final double elevation;

  // The text to be displayed beside the icon
  final String? text;

  // The text to be displayed beside the icon
  final TextStyle? textStyle;

  // The gap between the text and the icon
  final double textGap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        text != null ?
        Text(
          text!,
          style: textStyle,
        ) : const SizedBox.shrink(),
        SizedBox(width: textGap,),
        Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          color: color ?? theme.colorScheme.secondary,
          elevation: elevation,
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ],
    );
  }
}
