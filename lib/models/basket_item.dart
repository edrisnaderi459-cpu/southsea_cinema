class BasketItem {
  final String movieTitle;
  final double ticketPrice;
  int quantity;

  BasketItem({
    required this.movieTitle,
    required this.ticketPrice,
    this.quantity = 1,
  });

  double get totalPrice => ticketPrice * quantity;
}