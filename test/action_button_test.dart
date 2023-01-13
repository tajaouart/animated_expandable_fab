import 'package:animated_expandable_fab/expandable_fab/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ActionButton has correct default values',
      (WidgetTester tester) async {
    final button = ActionButton(
      child: const Text('Test'),
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
}
