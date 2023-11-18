import 'package:flutter/material.dart';

/// A widget that creates a floating action button (FAB) which can be tapped to close.
///
/// The widget displays a circular button with customizable elevation, shadow color,
/// background color, and an optional icon. When tapped, it triggers a provided callback.
class TapToCloseFab extends StatelessWidget {
  /// Determines whether the FAB is in open state.
  final bool open;

  /// Elevation for the FAB when it's in the closed state.
  final double closeElevation;

  /// Shadow color for the FAB when it's in the closed state.
  final Color? closeShadowColor;

  /// Background color for the FAB when it's in the closed state.
  final Color? closeBackgroundColor;

  /// Icon to display in the FAB when it's in the closed state.
  /// If null, no icon is displayed.
  final Widget? closeIcon;

  /// Callback function to execute when the FAB is tapped.
  final VoidCallback toggle;

  /// Creates an instance of [TapToCloseFab].
  ///
  /// All parameters are required except [closeIcon], which is optional.
  const TapToCloseFab({
    required this.closeBackgroundColor,
    required this.closeShadowColor,
    required this.closeElevation,
    required this.toggle,
    required this.open,
    this.closeIcon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: closeElevation,
          shadowColor: closeShadowColor,
          color: closeBackgroundColor,
          child: InkWell(
            onTap: toggle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: !open
                  ? const SizedBox()
                  : (closeIcon ??
                      Icon(
                        Icons.close,
                        color: Theme.of(context).primaryColor,
                      )),
            ),
          ),
        ),
      ),
    );
  }
}
