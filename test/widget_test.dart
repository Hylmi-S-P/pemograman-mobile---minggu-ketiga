import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pricing_card/main.dart';

void main() {
  Widget pumpAtSize(WidgetTester tester, Size size) {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    return const PricingCardApp();
  }

  testWidgets('Both packages render with the expected copy', (tester) async {
    await tester.pumpWidget(pumpAtSize(tester, const Size(600, 1200)));

    expect(find.text('Paket Starter'), findsOneWidget);
    expect(find.text('Paket Profesional'), findsOneWidget);
    expect(find.text('Rp 1.500.000'), findsOneWidget);
    expect(find.text('Rp 5.000.000'), findsOneWidget);
    expect(find.text('/ proyek'), findsNWidgets(2));
    expect(find.text('Rekomendasi'), findsOneWidget);
    expect(find.text('Pilih Paket'), findsNWidgets(2));
    expect(find.byIcon(Icons.smartphone), findsOneWidget);
    expect(find.byIcon(Icons.laptop_mac), findsOneWidget);
  });

  testWidgets('Single column layout on a portrait viewport', (tester) async {
    await tester.pumpWidget(pumpAtSize(tester, const Size(360, 800)));

    expect(find.byType(PricingCard), findsNWidgets(2));
    expect(tester.takeException(), isNull);

    final professionalRect = tester.getRect(find.text('Paket Profesional'));
    final starterRect = tester.getRect(find.text('Paket Starter'));
    expect(starterRect.top, greaterThan(professionalRect.bottom));

    final professionalCard = tester.getRect(
      find.byKey(const ValueKey('card-professional')),
    );
    expect(professionalCard.left, closeTo(30, 0.1));
  });

  testWidgets('Two column layout on a landscape viewport', (tester) async {
    await tester.pumpWidget(pumpAtSize(tester, const Size(960, 600)));

    expect(find.byType(PricingCard), findsNWidgets(2));
    expect(tester.takeException(), isNull);

    final professionalRect = tester.getRect(find.text('Paket Profesional'));
    final starterRect = tester.getRect(find.text('Paket Starter'));
    expect(professionalRect.left, lessThan(starterRect.left));
    expect(professionalRect.right, lessThan(starterRect.left));

    final professionalCard = tester.getRect(
      find.byKey(const ValueKey('card-professional')),
    );
    expect(professionalCard.left, closeTo(170, 0.1));
  });

  testWidgets(
    'Tapping Pilih Paket on the professional card surfaces feedback',
    (tester) async {
      await tester.pumpWidget(pumpAtSize(tester, const Size(600, 1200)));

      final professionalCard = find.ancestor(
        of: find.text('Paket Profesional'),
        matching: find.byType(PricingCard),
      );
      await tester.ensureVisible(
        find.descendant(
          of: professionalCard,
          matching: find.text('Pilih Paket'),
        ),
      );
      await tester.tap(
        find.descendant(
          of: professionalCard,
          matching: find.text('Pilih Paket'),
        ),
      );
      await tester.pump();

      expect(find.text('Paket Profesional dipilih'), findsOneWidget);
    },
  );

  testWidgets('Portrait stays single column near the breakpoint', (
    tester,
  ) async {
    await tester.pumpWidget(pumpAtSize(tester, const Size(721, 800)));

    expect(find.byType(PricingCard), findsNWidgets(2));
    expect(tester.takeException(), isNull);

    final professionalRect = tester.getRect(find.text('Paket Profesional'));
    final starterRect = tester.getRect(find.text('Paket Starter'));
    expect(starterRect.top, greaterThan(professionalRect.bottom));
  });

  testWidgets('Narrow landscape falls back to one column', (tester) async {
    await tester.pumpWidget(pumpAtSize(tester, const Size(600, 360)));

    expect(find.byType(PricingCard), findsNWidgets(2));
    expect(tester.takeException(), isNull);

    final professionalRect = tester.getRect(find.text('Paket Profesional'));
    final starterRect = tester.getRect(find.text('Paket Starter'));
    expect(starterRect.top, greaterThan(professionalRect.bottom));
  });

  testWidgets('Scroll uses clamping physics without stretch', (tester) async {
    await tester.pumpWidget(pumpAtSize(tester, const Size(360, 800)));

    final scrollView = tester.widget<SingleChildScrollView>(
      find.byType(SingleChildScrollView),
    );
    expect(scrollView.physics, isA<ClampingScrollPhysics>());

    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, 180));
    await tester.pump();

    expect(tester.takeException(), isNull);
  });

  testWidgets('Badge is only shown for the recommended package', (
    tester,
  ) async {
    await tester.pumpWidget(pumpAtSize(tester, const Size(600, 1200)));

    expect(find.text('Rekomendasi'), findsOneWidget);
    expect(
      find.descendant(
        of: find.ancestor(
          of: find.text('Paket Profesional'),
          matching: find.byType(PricingCard),
        ),
        matching: find.text('Rekomendasi'),
      ),
      findsOneWidget,
    );
  });
}
