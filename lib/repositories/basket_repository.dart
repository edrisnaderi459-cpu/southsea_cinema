import 'package:southsea_cinema/models/basket_item.dart';

class BasketRepository {
  BasketRepository._();

  static final BasketRepository instance = BasketRepository._();

  final List<BasketItem> _items = [];

  List<BasketItem> get items => List.unmodifiable(_items);

  double get total {
    return _items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  void addTicket({
    required String movieTitle,
    required double ticketPrice,
    String screeningDate = '',
  }) {
    final index = _items.indexWhere(
      (item) =>
          item.movieTitle == movieTitle &&
          item.ticketPrice == ticketPrice &&
          item.screeningDate == screeningDate,
    );

    if (index != -1) {
      _items[index].quantity++;
    } else {
      _items.add(
        BasketItem(
          movieTitle: movieTitle,
          ticketPrice: ticketPrice,
          screeningDate: screeningDate,
        ),
      );
    }
  }

  void removeTicket(String movieTitle) {
    final index = _items.indexWhere(
      (item) => item.movieTitle == movieTitle,
    );

    if (index == -1) {
      return;
    }

    if (_items[index].quantity > 1) {
      _items[index].quantity--;
    } else {
      _items.removeAt(index);
    }
  }

  void removeAllTickets(String movieTitle, String screeningDate) {
    _items.removeWhere(
      (item) =>
          item.movieTitle == movieTitle && item.screeningDate == screeningDate,
    );
  }

  void clearBasket() {
    _items.clear();
  }
}
