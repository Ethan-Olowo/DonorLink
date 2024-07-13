import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:donorlink/views/Splashscreen.dart';

void main() {
  group('Splashscreen', () {
    testWidgets('Displays app bar image', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Splashscreen()));

      expect(find.byKey(const Key('appBarImage')), findsOneWidget);
    });

    testWidgets('Displays back button', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Splashscreen()));

      expect(find.byKey(const Key('backButton')), findsOneWidget);
    });

    testWidgets('Displays create account text', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Splashscreen()));

      expect(find.byKey(const Key('createAccountText')), findsOneWidget);
    });

    testWidgets('Displays select user type text', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Splashscreen()));

      expect(find.byKey(const Key('selectUserTypeText')), findsOneWidget);
    });

    testWidgets('Displays donor button', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Splashscreen()));

      expect(find.byKey(const Key('donorButton')), findsOneWidget);
    });

    testWidgets('Displays organisation button', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Splashscreen()));

      expect(find.byKey(const Key('organisationButton')), findsOneWidget);
    });

    testWidgets('Displays reviewer button', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Splashscreen()));

      expect(find.byKey(const Key('reviewerButton')), findsOneWidget);
    });

    testWidgets('Navigates to Register screen when donor button is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Splashscreen()));

      await tester.tap(find.byKey(const Key('donorButton')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('donorRegister')), findsOneWidget);
    });

    testWidgets(
        'Navigates to Register screen when organisation button is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Splashscreen()));

      await tester.tap(find.byKey(const Key('organisationButton')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('organisationRegister')), findsOneWidget);
    });

    testWidgets('Navigates to Register screen when reviewer button is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Splashscreen()));

      await tester.tap(find.byKey(const Key('reviewerButton')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('reviewerRegister')), findsOneWidget);
    });
  });
}
