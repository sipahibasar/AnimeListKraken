import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:newkrakenanimelist/components/anime_detail_view.dart';
import 'package:newkrakenanimelist/components/anime_image.dart';
import 'package:newkrakenanimelist/components/anime_list_card.dart';
import 'package:newkrakenanimelist/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Test', () {
    testWidgets('Slow scroll, navigate to detail page, and verify characters', (WidgetTester tester) async {

      app.main();
      await tester.pumpAndSettle();

      expect(find.text('Top Anime'), findsOneWidget);

      await Future.delayed(const Duration(seconds: 2));

      final listFinder = find.byType(ListView);
      await tester.drag(listFinder, const Offset(0, -400));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 2));

      final firstAnime = find.byType(AnimeListCard).first;
      await tester.ensureVisible(firstAnime);
      await tester.pumpAndSettle(); // Ensure it's settled

      final offset = tester.getCenter(firstAnime);
      await tester.tapAt(offset);
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 2));

      print("Checking for 'Anime Detail' text...");
      expect(find.text('Anime Detail'), findsOneWidget);

      final animeImageFinder = find.descendant(
        of: find.byType(AnimeDetailView),
        matching: find.byType(AnimeImage),
      );
      expect(animeImageFinder, findsOneWidget);

      final detailScrollFinder = find.byType(SingleChildScrollView);
      await tester.drag(detailScrollFinder, const Offset(0, -200));
      await tester.pumpAndSettle();

      // Wait for a moment to inspect the Characters section
      await Future.delayed(const Duration(seconds: 2));

      // Verify that the Characters section and character images are visible
      expect(find.text('Characters'), findsOneWidget);

      // Ensure that at least one character image is present
      final characterImageFinder = find.byType(ListTile)
          .evaluate()
          .firstWhere(
            (element) => find.descendant(of: find.byWidget(element.widget), matching: find.byType(Image)).evaluate().isNotEmpty,
      );
      expect(characterImageFinder, isNotNull);

      // Slowly scroll further down if necessary to view more characters
      await tester.drag(detailScrollFinder, const Offset(0, -100));  // Short scroll
      await tester.pumpAndSettle();

      // Wait before going back
      await Future.delayed(const Duration(seconds: 2));

      // Go back to the AnimeListPage
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Wait before ending the test to inspect the AnimeListPage again
      await Future.delayed(const Duration(seconds: 2));

      // Verify that we're back on the AnimeListPage
      expect(find.text('Top Anime'), findsOneWidget);
    });
  });
}