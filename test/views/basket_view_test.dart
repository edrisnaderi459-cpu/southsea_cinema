import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/views/basket_view.dart';

void main() {
  final basket = BasketRepository.instance;

  setUp(() {
    basket.clearBasket();
  });

  testWidgets('Basket displays empty message', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: BasketView()),
    );

    expect(find.text('Your basket is empty'), findsOneWidget);
  });

  testWidgets('Basket displays added tickets and total', (tester) async {
    basket.addTicket(
      movieTitle: 'Interstellar',
      ticketPrice: 6.0,
      screeningDate: 'Sunday 4 Oct 2026 15:00',
    );

    basket.addTicket(
      movieTitle: 'Interstellar',
      ticketPrice: 6.0,
      screeningDate: 'Sunday 4 Oct 2026 15:00',
    );

    await tester.pumpWidget(
      const MaterialApp(home: BasketView()),
    );

    expect(find.text('2 Tickets'), findsOneWidget);
    expect(find.textContaining('Interstellar'), findsOneWidget);
    expect(find.text('£12.00'), findsOneWidget);
    expect(find.text('£16.00'), findsOneWidget);
  });

  testWidgets('Delete button removes tickets', (tester) async {
    basket.addTicket(
      movieTitle: 'Interstellar',
      ticketPrice: 6.0,
      screeningDate: 'Sunday 4 Oct 2026 15:00',
    );

    await tester.pumpWidget(
      const MaterialApp(home: BasketView()),
    );

    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();

    expect(find.text('Your basket is empty'), findsOneWidget);
  });

  testWidgets('Buy tickets clears the basket', (tester) async {
    basket.addTicket(
      movieTitle: 'Interstellar',
      ticketPrice: 6.0,
      screeningDate: 'Sunday 4 Oct 2026 15:00',
    );

    await tester.pumpWidget(
      const MaterialApp(home: BasketView()),
    );

    await tester.tap(find.text('BUY TICKETS'));
    await tester.pump();

    expect(find.text('Thank you for your order!'), findsOneWidget);
    expect(basket.items, isEmpty);
  });
}
