import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';

void main() {
  testWidgets(
    'Home page displays movies and booking buttons',
    (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());
      await tester.pumpAndSettle();

      expect(find.text('Southsea Cinema'), findsOneWidget);
      expect(find.textContaining('Interstellar'), findsOneWidget);
      expect(find.textContaining('Spider-Man'), findsOneWidget);
      expect(find.text('BOOK NOW'), findsNWidgets(2));
    },
  );

  testWidgets(
    'Tapping BOOK NOW opens the selected movie and allows booking',
    (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());
      await tester.pumpAndSettle();

      // Tap BOOK NOW for the first movie, Interstellar.
      await tester.tap(find.text('BOOK NOW').first);
      await tester.pumpAndSettle();

      // Check that the Interstellar listing page opened.
      expect(find.text('Interstellar (12A)'), findsOneWidget);
      expect(find.text('Southsea Cinema Room'), findsOneWidget);
      expect(
        find.text('Sunday 4 Oct 2026 15:00'),
        findsOneWidget,
      );
      expect(find.text('BOOK NOW'), findsNothing);
      expect(find.text('Add to order'), findsOneWidget);

      // Open the ticket quantity dropdown.
      
      // Scroll the ticket dropdown into view.
      await tester.ensureVisible(find.byType(DropdownMenu<int>));
      await tester.pumpAndSettle();

      // Open the ticket quantity dropdown.
      await tester.tap(find.byType(DropdownMenu<int>));
      await tester.pumpAndSettle();

      // Select one ticket.
      await tester.tap(find.text('1').last);
      await tester.pumpAndSettle();

      // Scroll the Add to order button into view.
      await tester.ensureVisible(find.text('Add to order'));
      await tester.pumpAndSettle();

      // Add the ticket to the order.
      await tester.tap(find.text('Add to order'));
      await tester.pumpAndSettle();

      // Check the booking confirmation message.
      expect(
        find.text('1 tickets added to the order'),
        findsOneWidget,
      );
    },
  );
}
