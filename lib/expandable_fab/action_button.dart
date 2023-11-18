import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  /// Creates a material design action button with an optional text label.
  ///
  /// The button can display an icon or other widget, specified by [icon],
  /// and an optional text label. The appearance of the button can be customized
  /// with various styling parameters.
  const ActionButton({
    this.padding = const EdgeInsets.all(12.0),
    this.buttonShape = const CircleBorder(),
    this.clipBehavior = Clip.antiAlias,
    this.closeFabOnTap = true,
    required this.icon,
    this.elevation = 4.0,
    this.shadowColor,
    this.textColor,
    this.onPressed,
    this.color,
    this.text,
    super.key,
  });

  /// The callback that is called when the button is tapped.
  final VoidCallback? onPressed;

  /// The widget (typically an icon) displayed in the button.
  final Widget icon;

  /// Optional text label to display alongside the [icon].
  final Widget? text;

  /// Color of the text label.
  final Color? textColor;

  /// The background color of the button.
  final Color? color;

  /// Indicates whether the FAB should close when the button is tapped.
  final bool closeFabOnTap;

  /// The shape of the button.
  final ShapeBorder buttonShape;

  /// The clip behavior of the button.
  final Clip clipBehavior;

  /// The elevation of the button.
  final double elevation;

  /// The shadow color of the button.
  final Color? shadowColor;

  /// The padding inside the button.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (text != null) text!,
        Material(
          shape: buttonShape,
          clipBehavior: clipBehavior,
          color: color ?? theme.colorScheme.secondary,
          elevation: elevation,
          shadowColor: shadowColor ?? theme.shadowColor,
          child: Padding(
            padding: padding,
            child: icon,
          ),
        ),
      ],
    );
  }
}
