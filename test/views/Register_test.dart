import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:donorlink/views/Register.dart';

void main() {
  group('Register widget tests', () {
    testWidgets('Register widget renders correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Register(userType: 'Donor'),
        ),
      );

      expect(find.byType(Register), findsOneWidget);
      expect(find.text('Donor Registration'), findsOneWidget);
    });
    
  });
}
