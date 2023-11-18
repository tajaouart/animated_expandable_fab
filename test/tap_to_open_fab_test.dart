import 'package:animated_expandable_fab/expandable_fab/tap_to_open_fab.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('TapToOpenFab changes appearance when open',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TapToOpenFab(
          open: true,
          openElevation: 4.0,
          toggle: () {},
          openIcon: const Icon(Icons.add),
        ),
      ),
    );

    // Check if the FAB is faded out and shrunk
    final animatedContainer =
        tester.widget<AnimatedContainer>(find.byType(AnimatedContainer));
    expect(animatedContainer.transform, Matrix4.diagonal3Values(0.7, 0.7, 1.0));

    final animatedOpacity =
        tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity));
    expect(animatedOpacity.opacity, 0.0);
  });

  testWidgets('TapToOpenFab toggle callback is called',
      (WidgetTester tester) async {
    bool toggleCalled = false;
    await tester.pumpWidget(
      MaterialApp(
        home: TapToOpenFab(
          open: false,
          openElevation: 4.0,
          toggle: () {
            toggleCalled = true;
          },
          openIcon: const Icon(Icons.add),
        ),
      ),
    );

    await tester.tap(find.byType(FloatingActionButton));
    expect(toggleCalled, true);
  });

  testWidgets('TapToOpenFab has correct elevation',
      (WidgetTester tester) async {
    const double openElevation = 6.0;
    await tester.pumpWidget(
      MaterialApp(
        home: TapToOpenFab(
          open: false,
          openElevation: openElevation,
          toggle: () {},
          openIcon: const Icon(Icons.add),
        ),
      ),
    );

    final fab =
        tester.widget<FloatingActionButton>(find.byType(FloatingActionButton));
    expect(fab.elevation, openElevation);
  });
}
