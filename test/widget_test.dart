
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';

void main() {
  testWidgets('Home page displays movies and booking buttons',
      (WidgetTester tester) async {
    // Launch the app.
    await tester.pumpWidget(const SouthseaCinemaApp());

    // Wait for the widget tree to settle.
    await tester.pumpAndSettle();

    // Check the app title.
    expect(find.text('Southsea Cinema'), findsOneWidget);

    // Check the movie titles.
    expect(find.textContaining('Interstellar'), findsOneWidget);
    expect(find.textContaining('Spider-Man'), findsOneWidget);

    // Check the booking buttons.
    expect(find.text('BOOK NOW'), findsNWidgets(2));
  });
}
