import 'package:animated_expandable_fab/animated_expandable_fab.dart';
import 'package:animated_expandable_fab/expandable_fab/tap_to_open_fab.dart';
import 'package:flutter/material.dart';

import 'tap_to_close_fab.dart';
import 'expanding_action_button.dart';

/// A stateful widget that creates an expandable Floating Action Button (FAB).
///
/// This widget allows the integration of multiple action buttons within a single FAB.
/// The FAB can toggle between an open and closed state, revealing or hiding the action buttons.
class ExpandableFab extends StatefulWidget {
  /// Determines whether the FAB is open or closed initially.
  final bool initialOpen;

  /// The distance between the main FAB and the expanded action buttons.
  final double distance;

  /// A list of action buttons that are displayed when the FAB is expanded.
  final List<ActionButton> children;

  /// The icon displayed on the FAB when it is in its closed state.
  /// If null, a default icon may be used.
  final Widget? closeIcon;

  /// The icon displayed on the FAB when it is in its open state.
  /// If null, a default icon may be used.
  final Widget? openIcon;

  /// The elevation of the FAB when it is in the open state.
  /// If null, a default elevation may be applied.
  final double? openElevation;

  /// The elevation of the FAB when it is in the closed state.
  /// Defaults to 4.0 if not specified.
  final double closeElevation;

  /// The color of the shadow cast by the FAB when it is in the closed state.
  /// If null, the default shadow color is used.
  final Color? closeShadowColor;

  /// The background color of the FAB when it is in the closed state.
  /// If null, a default color is used.
  final Color? closeBackgroundColor;

  /// Constructs an [ExpandableFab].
  ///
  /// Requires [distance] and [children]. Other parameters are optional and have default values.
  const ExpandableFab({
    this.closeBackgroundColor,
    this.closeElevation = 4.0,
    this.initialOpen = false,
    required this.children,
    required this.distance,
    this.closeShadowColor,
    this.openElevation,
    this.closeIcon,
    this.openIcon,
    super.key,
  });

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  late bool _isOpen = widget.initialOpen;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      // setting the initial value of the animation
      value: _isOpen ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  // the main build function
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          TapToCloseFab(
            closeBackgroundColor: widget.closeBackgroundColor,
            closeShadowColor: widget.closeShadowColor,
            closeElevation: widget.closeElevation,
            closeIcon: closeIcon,
            open: _isOpen,
            // Optional
            toggle: _toggleFab,
          ),
          ..._buildExpandingActionButtons(),
          TapToOpenFab(
            openIcon: widget.openIcon,
            openElevation: widget.openElevation,
            toggle: _toggleFab,
            open: _isOpen,
          )
        ],
      ),
    );
  }

  // toggle the state of the fab when it is tapped
  void _toggleFab() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  // builds the expanding action buttons
  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
          onTap: () {
            if (widget.children[i].closeFabOnTap) {
              _toggleFab();
            }
            widget.children[i].onPressed?.call();
          },
        ),
      );
    }
    return children;
  }

  Widget get closeIcon => _isOpen == false
      ? const SizedBox()
      : (widget.closeIcon ??
          Icon(
            Icons.close,
            color: Theme.of(context).primaryColor,
          ));

  // dispose the animation controller when the widget is disposed
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
