// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:porfolio/main.dart';

void main() {
  testWidgets('portfolio renders premium Flutter developer homepage', (tester) async {
    await tester.pumpWidget(const ShraddhaPortfolioApp());

    expect(find.text('FLUTTER DEVELOPER'), findsOneWidget);
    expect(find.text('Shraddha Pandey'), findsWidgets);
    expect(find.text('Selected Work'), findsOneWidget);
    expect(find.text('Professional Journey'), findsOneWidget);
  });
}
