import 'package:animated_expandable_fab/expandable_fab/action_button.dart';
import 'package:animated_expandable_fab/expandable_fab/expandable_fab.dart';
import 'package:animated_expandable_fab/expandable_fab/expanding_action_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('ExpandableFab initial state open/close', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SizedBox(
          height: 600,
          width: 300,
          child: Scaffold(
            floatingActionButton: ExpandableFab(
              initialOpen: true,
              distance: 0.0,
              children: [],
            ),
          ),
        ),
      ),
    );

    expect(find.byType(ExpandingActionButton), findsNothing);

    await tester.pumpWidget(
      const MaterialApp(
        home: SizedBox(
          height: 600,
          width: 300,
          child: Scaffold(
            floatingActionButton: ExpandableFab(
              initialOpen: false,
              distance: 0.0,
              children: [],
            ),
          ),
        ),
      ),
    );

    expect(find.byType(ExpandingActionButton), findsNothing);
  });

  testWidgets('ExpandableFab open and close actions ', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SizedBox(
          height: 600,
          width: 300,
          child: Scaffold(
            floatingActionButton: ExpandableFab(
              initialOpen: true,
              distance: 100.0,
              openIcon: Icon(Icons.menu),
              children: [
                ActionButton(
                  closeFabOnTap: true,
                  icon: Text('Test'),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle(const Duration(seconds: 1));

    // Check if the closeIcon is displayed
    expect(find.byIcon(Icons.close), findsOneWidget);

    // tap on closeIcon
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // Check if the openIcon is displayed & closeIcon is not displayed
    expect(find.byIcon(Icons.menu), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.byIcon(Icons.close), findsNothing);

    // tap on openIcon
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // Check if the closeIcon is displayed
    expect(find.byIcon(Icons.close), findsOneWidget);

    // Check if the openIcon is not displayed
    expect(find.byIcon(Icons.menu), findsNothing);
  });

  testWidgets("ExpandableFab children", (WidgetTester tester) async {
    const child1 = ActionButton(
      icon: Text('Child 1'),
    );
    const child2 = ActionButton(
      icon: Text('Child 2'),
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: SizedBox(
          height: 600,
          width: 300,
          child: Scaffold(
            floatingActionButton: ExpandableFab(
              distance: 100,
              children: [child1, child2],
            ),
          ),
        ),
      ),
    );

    final child1Finder = find.byWidget(child1);
    final child2Finder = find.byWidget(child2);
    // Check if both children are visible
    expect(child1Finder, findsOneWidget);
    expect(child2Finder, findsOneWidget);
  });

  testWidgets('ExpandableFab open and tap on child then close manually',
      (tester) async {
    bool onPressedCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: SizedBox(
          width: 300,
          height: 600,
          child: Scaffold(
            floatingActionButton: ExpandableFab(
              initialOpen: false,
              distance: 0,
              children: [
                ActionButton(
                  closeFabOnTap: false,
                  key: const Key('Child1'),
                  icon: const Text('Test'),
                  onPressed: () {
                    onPressedCalled = true;
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );

    // open fab
    await tester.tap(find.byType(ActionButton));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // tap on child
    await tester.tap(find.byKey(const Key('Child1')));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // close fab
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(onPressedCalled, true);
  });

  testWidgets('ExpandableFab open and tap on child then close automatically',
      (tester) async {
    bool onPressedCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: SizedBox(
          width: 300,
          height: 600,
          child: Scaffold(
            floatingActionButton: ExpandableFab(
              initialOpen: false,
              distance: 0,
              children: [
                ActionButton(
                  closeFabOnTap: true,
                  key: const Key('Child1'),
                  icon: const Text('Test'),
                  onPressed: () {
                    onPressedCalled = true;
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );

    // open fab
    await tester.tap(find.byType(ActionButton));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // tap on child
    await tester.tap(find.byKey(const Key('Child1')));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // close button is hidden because fab is close after clicking on child
    // (closeFabOnTap == true)
    expect(find.byIcon(Icons.close), findsNothing);

    expect(onPressedCalled, true);
  });
}
