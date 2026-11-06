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
  }) {
    final index = _items.indexWhere(
      (item) =>
          item.movieTitle == movieTitle &&
          item.ticketPrice == ticketPrice,
    );

    if (index != -1) {
      _items[index].quantity++;
    } else {
      _items.add(
        BasketItem(
          movieTitle: movieTitle,
          ticketPrice: ticketPrice,
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

  void clearBasket() {
    _items.clear();
  }
}