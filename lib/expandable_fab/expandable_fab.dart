import 'package:animated_expandable_fab/animated_expandable_fab.dart';
import 'package:flutter/material.dart';

import 'expanding_action_button.dart';

// ExpandableFab is a stateful widget that allows creating an expandable Floating Action Button
// which can contain multiple action buttons inside it.
class ExpandableFab extends StatefulWidget {
  const ExpandableFab(
      {super.key,
      // boolean variable to determine if the fab should be open or closed by default
      this.initialOpen = false,
      // the distance between the fab and the action buttons
      required this.distance,
      // the list of action buttons to be added to the fab
      required this.children,
      // the icon to be displayed when the fab is closed
      this.closeIcon,
      // the icon to be displayed when the fab is open
      this.openIcon,
      // the background color of the closed icon
      this.closeIconBackgroundColor,
      // the background color of the open icon
      this.openIconBackgroundColor,
      //Tag for first floating action button shown
      this.heroTag1,
      //Tag for second floating action button shown
      this.heroTag2});

  final bool initialOpen;
  final double distance;
  final List<ActionButton> children;
  final Widget? closeIcon;
  final Widget? openIcon;
  final Color? openIconBackgroundColor;
  final Color? closeIconBackgroundColor;
  final Object? heroTag1;
  final Object? heroTag2;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    // initializing the state of the fab
    _open = widget.initialOpen;
    _controller = AnimationController(
      // setting the initial value of the animation
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  // dispose the animation controller when the widget is disposed
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // toggle the state of the fab when it is tapped
  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  // the main build function
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  // the tap-to-close fab widget
  Widget _buildTapToCloseFab() {
    return FloatingActionButton(
      onPressed: _toggle,
      heroTag: widget.heroTag1 ?? UniqueKey(),
      backgroundColor: widget.closeIconBackgroundColor ?? Colors.white,
      child: (widget.closeIcon ??
          Icon(
            Icons.close,
            color: Theme.of(context).primaryColor,
          )),
    );
    // return SizedBox(
    //   width: 56.0,
    //   height: 56.0,
    //   child: Center(
    //     child: Material(
    //       color: widget.closeIconBackgroundColor,
    //       shape: const CircleBorder(),
    //       clipBehavior: Clip.antiAlias,
    //       elevation: 4.0,
    //       child: InkWell(
    //         onTap: _toggle,
    //         child: Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: _open == false
    //               ? const SizedBox()
    //               : (widget.closeIcon ??
    //                   Icon(
    //                     Icons.close,
    //                     color: Theme.of(context).primaryColor,
    //                   )),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
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
              _toggle();
            }
            widget.children[i].onPressed?.call();
          },
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            heroTag: widget.heroTag2 ?? UniqueKey(),
            backgroundColor: widget.openIconBackgroundColor,
            onPressed: _toggle,
            child: _open
                ? const SizedBox()
                : (widget.openIcon ?? const Icon(Icons.add)),
          ),
        ),
      ),
    );
  }
}
