import 'package:animated_expandable_fab/expandable_fab/tap_to_close_fab.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('TapToCloseFab displays correct icon when open',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TapToCloseFab(
          open: true,
          closeElevation: 4.0,
          closeBackgroundColor: Colors.blue,
          closeShadowColor: Colors.grey,
          toggle: () {},
          closeIcon: const Icon(Icons.close),
        ),
      ),
    );

    expect(find.byIcon(Icons.close), findsOneWidget);
  });

  testWidgets('TapToCloseFab is invisible when closed',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TapToCloseFab(
          open: false,
          closeElevation: 4.0,
          closeBackgroundColor: Colors.blue,
          closeShadowColor: Colors.grey,
          toggle: () {},
          closeIcon: const Icon(Icons.close),
        ),
      ),
    );

    expect(find.byIcon(Icons.close), findsNothing);
  });

  testWidgets('TapToCloseFab toggle callback is called',
      (WidgetTester tester) async {
    bool toggleCalled = false;
    await tester.pumpWidget(
      MaterialApp(
        home: TapToCloseFab(
          open: true,
          closeElevation: 4.0,
          closeBackgroundColor: Colors.blue,
          closeShadowColor: Colors.grey,
          toggle: () {
            toggleCalled = true;
          },
          closeIcon: const Icon(Icons.close),
        ),
      ),
    );

    await tester.tap(find.byType(InkWell));
    expect(toggleCalled, true);
  });

  testWidgets('TapToCloseFab has correct elevation and colors',
      (WidgetTester tester) async {
    const double closeElevation = 6.0;
    const Color backgroundColor = Colors.red;
    const Color shadowColor = Colors.black;

    await tester.pumpWidget(
      MaterialApp(
        home: TapToCloseFab(
          open: true,
          closeElevation: closeElevation,
          closeBackgroundColor: backgroundColor,
          closeShadowColor: shadowColor,
          toggle: () {},
          closeIcon: const Icon(Icons.close),
        ),
      ),
    );

    final material = tester.widget<Material>(find.byType(Material));
    expect(material.elevation, closeElevation);
    expect(material.color, backgroundColor);
    expect(material.shadowColor, shadowColor);
  });
}
