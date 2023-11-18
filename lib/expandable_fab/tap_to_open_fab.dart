import 'package:flutter/material.dart';

/// A widget that creates a floating action button (FAB) which can be tapped to open.
///
/// The FAB animates and changes its appearance based on the open state.
/// It shrinks and fades out when open, and returns to normal size with an icon when closed.
class TapToOpenFab extends StatelessWidget {
  /// The open state of the FAB. Determines the appearance and interaction of the FAB.
  final bool open;

  /// The callback function to execute when the FAB is tapped.
  final VoidCallback toggle;

  /// The elevation of the FAB when it's in the open state.
  final double? openElevation;

  /// The icon to display in the FAB when it's in the closed state.
  /// If null, a default '+' icon is displayed.
  final Widget? openIcon;

  /// Creates an instance of [TapToOpenFab].
  ///
  /// Requires [open], [toggle], and [openElevation]. The [openIcon] is optional.
  const TapToOpenFab({
    required this.openElevation,
    required this.toggle,
    required this.open,
    this.openIcon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          open ? 0.7 : 1.0,
          open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: toggle,
            elevation: openElevation,
            child: open ? const SizedBox() : openIcon,
          ),
        ),
      ),
    );
  }
}
