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

  testWidgets('Screen 1 displays 3 catalog cards and AppBar', (tester) async {
    await tester.pumpWidget(pumpAtSize(tester, const Size(600, 1200)));

    expect(find.text('Katalog Paket Layanan'), findsOneWidget);
    expect(find.text('Paket Starter'), findsOneWidget);
    expect(find.text('Paket Profesional'), findsOneWidget);
    expect(find.text('Paket Enterprise'), findsOneWidget);

    expect(find.text('Rp 1.500.000'), findsOneWidget);
    expect(find.text('Rp 5.000.000'), findsOneWidget);
    expect(find.text('Rp 12.000.000'), findsOneWidget);

    expect(find.text('★ Rekomendasi Pilihan'), findsOneWidget);
  });

  testWidgets('Navigating to Screen 2 and popping back via back button', (
    tester,
  ) async {
    await tester.pumpWidget(pumpAtSize(tester, const Size(600, 1200)));

    // Tap on the first card (Paket Starter)
    await tester.tap(find.text('Paket Starter'));
    await tester.pumpAndSettle();

    // Verify Screen 2 (DetailCatalogScreen) is presented
    expect(find.byType(DetailCatalogScreen), findsOneWidget);
    expect(find.text('Ringkasan & Deskripsi Paket'), findsOneWidget);
    expect(find.text('Pilih & Konfirmasi Paket Ini'), findsOneWidget);

    // Tap the back button in AppBar
    await tester.tap(find.byTooltip('Kembali ke Katalog'));
    await tester.pumpAndSettle();

    // Verify we are back on Screen 1
    expect(find.byType(CatalogHomeScreen), findsOneWidget);
    expect(find.byType(DetailCatalogScreen), findsNothing);
  });

  testWidgets('Screen 2 stateful interactions (Bookmark, Counter, & Select)', (
    tester,
  ) async {
    await tester.pumpWidget(pumpAtSize(tester, const Size(600, 1200)));

    // Open detail of Paket Profesional
    await tester.tap(find.text('Paket Profesional'));
    await tester.pumpAndSettle();

    // Test Bookmark toggle
    expect(find.byIcon(Icons.bookmark_border), findsAtLeastNWidgets(1));
    await tester.tap(find.byTooltip('Simpan ke Favorit'));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.bookmark), findsAtLeastNWidgets(1));

    // Test Quantity Counter
    expect(find.text('1'), findsOneWidget);
    expect(find.text('Rp 5.000.000'), findsNWidgets(2)); // price & initial total

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    expect(find.text('2'), findsOneWidget);
    expect(find.text('Rp 10.000.000'), findsOneWidget);

    // Test Confirmation button state
    await tester.tap(find.text('Pilih & Konfirmasi Paket Ini'));
    await tester.pumpAndSettle();
    expect(
      find.text('✓ Paket Telah Dipilih (Klik untuk Batalkan)'),
      findsOneWidget,
    );
  });
}
