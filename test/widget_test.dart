// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hamza_portfolio_app/main.dart';

void main() {
  testWidgets('PortfolioApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(PortfolioApp());

    // Example check: Verify the app title text exists somewhere.
    expect(find.text('Hamza Jadoon - Portfolio'), findsOneWidget);

    // You can add more tests here that make sense for your portfolio app.
  });
}
