// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:alert_plus_example/main.dart';

void main() {
  testWidgets('Alert Plus Demo app loads correctly', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app title is displayed.
    expect(find.text('Alerts Package Demo'), findsOneWidget);

    // Verify that the welcome message is displayed.
    expect(find.text('🎉 Welcome to Alerts Package Demo!'), findsOneWidget);

    // Verify that the description text is displayed.
    expect(
      find.text(
        'Tap the buttons below to see different alert dialog examples:',
      ),
      findsOneWidget,
    );

    // Verify that at least one demo button is present.
    expect(find.text('Basic Alert'), findsOneWidget);
  });
}
