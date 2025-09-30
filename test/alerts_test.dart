import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_alerts/flutter_alerts.dart';

void main() {
  group('AlertButton', () {
    test('should create AlertButton with required parameters', () {
      final button = AlertButton(label: 'Test Button', onPressed: () {});

      expect(button.label, 'Test Button');
      expect(button.onPressed, isNotNull);
      expect(button.textStyle, isNull);
      expect(button.backgroundColor, isNull);
    });

    test('should create AlertButton with all parameters', () {
      final textStyle = TextStyle(color: Colors.red);
      final backgroundColor = Colors.blue;

      final button = AlertButton(
        label: 'Styled Button',
        onPressed: () {},
        textStyle: textStyle,
        backgroundColor: backgroundColor,
      );

      expect(button.label, 'Styled Button');
      expect(button.onPressed, isNotNull);
      expect(button.textStyle, textStyle);
      expect(button.backgroundColor, backgroundColor);
    });

    test('should handle null onPressed', () {
      final button = AlertButton(label: 'Disabled Button', onPressed: null);

      expect(button.label, 'Disabled Button');
      expect(button.onPressed, isNull);
    });
  });

  group('AlertInputField', () {
    test('should create AlertInputField with required parameters', () {
      final field = AlertInputField(hintText: 'Enter text');

      expect(field.hintText, 'Enter text');
      expect(field.controller, isNull);
      expect(field.obscureText, false);
      expect(field.keyboardType, TextInputType.text);
    });

    test('should create AlertInputField with all parameters', () {
      final controller = TextEditingController();
      final field = AlertInputField(
        hintText: 'Enter email',
        controller: controller,
        obscureText: true,
        keyboardType: TextInputType.emailAddress,
      );

      expect(field.hintText, 'Enter email');
      expect(field.controller, controller);
      expect(field.obscureText, true);
      expect(field.keyboardType, TextInputType.emailAddress);
    });
  });

  group('AlertTheme', () {
    test('should create AlertTheme with default values', () {
      final theme = AlertTheme();

      expect(theme.backgroundColor, isNull);
      expect(theme.titleColor, isNull);
      expect(theme.contentColor, isNull);
      expect(theme.borderRadius, isNull);
      expect(theme.padding, isNull);
    });

    test('should create AlertTheme with custom values', () {
      final backgroundColor = Colors.white;
      final titleColor = Colors.black;
      final contentColor = Colors.grey;
      final borderRadius = BorderRadius.circular(12.0);
      final padding = EdgeInsets.all(20.0);

      final theme = AlertTheme(
        backgroundColor: backgroundColor,
        titleColor: titleColor,
        contentColor: contentColor,
        borderRadius: borderRadius,
        padding: padding,
      );

      expect(theme.backgroundColor, backgroundColor);
      expect(theme.titleColor, titleColor);
      expect(theme.contentColor, contentColor);
      expect(theme.borderRadius, borderRadius);
      expect(theme.padding, padding);
    });
  });

  group('AlertAnimation', () {
    test('should have correct enum values', () {
      expect(AlertAnimation.none, equals(AlertAnimation.none));
      expect(AlertAnimation.fade, equals(AlertAnimation.fade));
      expect(AlertAnimation.slideUp, equals(AlertAnimation.slideUp));
      expect(AlertAnimation.scale, equals(AlertAnimation.scale));
    });
  });

  group('CustomAlertDialog', () {
    testWidgets('should create CustomAlertDialog with default parameters', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: CustomAlertDialog())),
      );

      expect(find.byType(CustomAlertDialog), findsOneWidget);
    });

    testWidgets('should display title when provided', (
      WidgetTester tester,
    ) async {
      const title = 'Test Title';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: CustomAlertDialog(title: title)),
        ),
      );

      expect(find.text(title), findsOneWidget);
    });

    testWidgets('should display content when provided', (
      WidgetTester tester,
    ) async {
      const content = 'Test Content';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: CustomAlertDialog(content: content)),
        ),
      );

      expect(find.text(content), findsOneWidget);
    });

    testWidgets('should display buttons when provided', (
      WidgetTester tester,
    ) async {
      final buttons = [
        AlertButton(label: 'OK', onPressed: () {}),
        AlertButton(label: 'Cancel', onPressed: () {}),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: CustomAlertDialog(buttons: buttons)),
        ),
      );

      expect(find.text('OK'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('should display input fields when provided', (
      WidgetTester tester,
    ) async {
      final inputFields = [
        AlertInputField(hintText: 'Name'),
        AlertInputField(hintText: 'Email'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: CustomAlertDialog(inputFields: inputFields)),
        ),
      );

      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets('should use custom theme', (WidgetTester tester) async {
      final theme = AlertTheme(
        backgroundColor: Colors.red,
        titleColor: Colors.blue,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomAlertDialog(title: 'Themed Dialog', theme: theme),
          ),
        ),
      );

      expect(find.text('Themed Dialog'), findsOneWidget);
      // Note: Testing actual theme application would require more complex widget testing
    });
  });

  group('showCustomAlertDialog', () {
    testWidgets('should show dialog with basic parameters', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showCustomAlertDialog(
                  context,
                  title: 'Test Dialog',
                  content: 'Test content',
                  buttons: [AlertButton(label: 'OK', onPressed: () {})],
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Test Dialog'), findsOneWidget);
      expect(find.text('Test content'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
    });

    testWidgets('should handle dialog dismissal', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showCustomAlertDialog(
                  context,
                  title: 'Dismissible Dialog',
                  buttons: [
                    AlertButton(
                      label: 'Close',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Dismissible Dialog'), findsOneWidget);

      await tester.tap(find.text('Close'));
      await tester.pumpAndSettle();

      expect(find.text('Dismissible Dialog'), findsNothing);
    });

    testWidgets('should support barrier dismissal', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showCustomAlertDialog(
                  context,
                  title: 'Barrier Dismissible',
                  barrierDismissible: true,
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Barrier Dismissible'), findsOneWidget);

      // Tap outside the dialog to dismiss
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      expect(find.text('Barrier Dismissible'), findsNothing);
    });

    testWidgets('should support different animations', (
      WidgetTester tester,
    ) async {
      for (final animation in AlertAnimation.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () => showCustomAlertDialog(
                    context,
                    title: 'Animated Dialog',
                    animation: animation,
                    buttons: [
                      AlertButton(
                        label: 'OK',
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  child: const Text('Show Dialog'),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        expect(find.text('Animated Dialog'), findsOneWidget);

        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();
      }
    });

    testWidgets('should handle input fields', (WidgetTester tester) async {
      final nameController = TextEditingController();
      final emailController = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showCustomAlertDialog(
                  context,
                  title: 'Input Dialog',
                  inputFields: [
                    AlertInputField(
                      hintText: 'Name',
                      controller: nameController,
                    ),
                    AlertInputField(
                      hintText: 'Email',
                      controller: emailController,
                    ),
                  ],
                  buttons: [
                    AlertButton(
                      label: 'Submit',
                      onPressed: () {
                        nameController.text = 'John Doe';
                        emailController.text = 'john@example.com';
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Input Dialog'), findsOneWidget);
      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);

      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      expect(nameController.text, 'John Doe');
      expect(emailController.text, 'john@example.com');
    });
  });
}
