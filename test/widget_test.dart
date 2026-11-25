// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jelajah_mojokerto/main.dart';

void main() {
  testWidgets('Aplikasi Jelajah Mojokerto memuat halaman utama dengan benar',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: JelajahMojokertoApp(),
      ),
    );

    // Verifikasi bahwa judul aplikasi pada AppBar muncul
    expect(find.text('Jelajah Mojokerto - Adhim'), findsOneWidget);

    // Verifikasi label navigasi utama
    expect(find.text('Beranda'), findsOneWidget);
    expect(find.text('Jelajah'), findsOneWidget);
    expect(find.text('Favorit'), findsOneWidget);
  });
}
