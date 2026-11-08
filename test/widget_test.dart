import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';

Future<void> pumpHomePage(WidgetTester tester) async {
  await tester.pumpWidget(const SouthseaCinemaApp());

  await tester.runAsync(() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
  });

  await tester.pump();

  expect(find.text('BOOK NOW'), findsNWidgets(2));
}

Future<void> addOneTicket(WidgetTester tester, int movieIndex) async {
  final bookNowButton = find.text('BOOK NOW').at(movieIndex);

  // Scroll the movie button into view.
  await tester.ensureVisible(bookNowButton);
  await tester.pumpAndSettle();

  await tester.tap(bookNowButton);
  await tester.pumpAndSettle();

  await tester.ensureVisible(find.byType(DropdownMenu<int>));
  await tester.pumpAndSettle();

  await tester.tap(find.byType(DropdownMenu<int>));
  await tester.pumpAndSettle();

  await tester.tap(find.text('1').last);
  await tester.pumpAndSettle();

  await tester.ensureVisible(find.text('Add to order'));
  await tester.pumpAndSettle();

  await tester.tap(find.text('Add to order'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets(
    'JSON movies can be booked, removed and checked out',
    (WidgetTester tester) async {
      final basket = BasketRepository.instance;
      basket.clearBasket();

      // Load the movies from the JSON asset.
      await pumpHomePage(tester);

      expect(find.textContaining('Interstellar'), findsOneWidget);
      expect(find.textContaining('Spider-Man'), findsOneWidget);

      // Book one Interstellar ticket.
      await addOneTicket(tester, 0);

      // Return to the home page using the navigation drawer.
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();

      // Book one Spider-Man ticket.
      await addOneTicket(tester, 1);

      // Check that both tickets have been added.
      expect(basket.items.length, 2);

      // Open the navigation drawer.
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Open My Basket.
      await tester.tap(find.text('My Basket'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Interstellar'), findsOneWidget);
      expect(find.textContaining('Spider-Man'), findsOneWidget);

      // Remove the first film from the basket.
      await tester.tap(find.byIcon(Icons.delete).first);
      await tester.pumpAndSettle();

      // Check that Spider-Man remains.
      expect(find.textContaining('Spider-Man'), findsOneWidget);
      expect(find.textContaining('Interstellar'), findsNothing);
      expect(basket.items.length, 1);

      // Complete checkout.
      await tester.tap(find.text('BUY TICKETS'));
      await tester.pumpAndSettle();

      // Check that checkout clears the in-memory basket.
      expect(find.text('Thank you for your order!'), findsOneWidget);
      expect(basket.items, isEmpty);
    },
  );
}
