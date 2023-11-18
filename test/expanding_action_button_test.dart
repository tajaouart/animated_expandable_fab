import 'package:animated_expandable_fab/expandable_fab/action_button.dart';
import 'package:animated_expandable_fab/expandable_fab/expanding_action_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('ExpandingActionButton calls onTap callback', (tester) async {
    bool onPressedCalled = false;
    bool onTapCalled = false;

    final actionButton = ActionButton(
      icon: const Text('Test'),
      onPressed: () {
        onPressedCalled = true;
      },
    );

    await tester.pumpWidget(
      MaterialApp(
        home: SizedBox(
          height: 600,
          width: 300,
          child: SizedBox.expand(
            child: Stack(
              children: [
                ExpandingActionButton(
                  key: const Key('ExpandingActionButton'),
                  directionInDegrees: 0.0,
                  maxDistance: 0.0,
                  progress: AnimationController(vsync: tester).view,
                  child: actionButton,
                  onTap: () {
                    actionButton.onPressed?.call();
                    onTapCalled = true;
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(const Key('ExpandingActionButton')));
    expect(onPressedCalled, true);
    expect(onTapCalled, true);
  });
}
