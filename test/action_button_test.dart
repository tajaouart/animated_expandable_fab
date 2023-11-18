import 'package:animated_expandable_fab/expandable_fab/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ActionButton has correct default values',
      (WidgetTester tester) async {
    final button = ActionButton(
      icon: const Text('Test'),
      onPressed: () {},
    );

    await tester.pumpWidget(MaterialApp(home: button));

    final material = tester.widget<Material>(find.byType(Material));
    expect(material.clipBehavior, Clip.antiAlias);
    expect(material.elevation, 4.0);
    expect(material.shape, const CircleBorder());

    final padding = tester.widget<Padding>(find.byType(Padding));
    expect(padding.padding, const EdgeInsets.all(12.0));
    expect(padding.child, isA<Text>());
  });

  testWidgets('ActionButton displays text when provided',
      (WidgetTester tester) async {
    const testText = 'Test Text';
    final button = ActionButton(
      text: const Text(testText),
      onPressed: () {},
      icon: const Icon(Icons.add),
    );

    await tester.pumpWidget(MaterialApp(home: button));

    expect(find.text(testText), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('ActionButton does not display text when not provided',
      (WidgetTester tester) async {
    final button = ActionButton(
      icon: const Icon(Icons.add),
      onPressed: () {},
    );

    await tester.pumpWidget(MaterialApp(home: button));

    expect(find.byType(Text), findsNothing);
  });

  testWidgets('ActionButton applies custom text styles',
      (WidgetTester tester) async {
    const testText = 'Styled Text';
    const textStyle = TextStyle(
      color: Colors.red,
      fontSize: 20,
    );
    final button = ActionButton(
      text: const Text(
        testText,
        style: textStyle,
      ),
      onPressed: () {},
      icon: const Icon(Icons.add),
    );

    await tester.pumpWidget(MaterialApp(home: button));

    final textWidget = tester.widget<Text>(find.text(testText));
    expect(textWidget.style, textStyle);
  });
}
