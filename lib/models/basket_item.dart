class BasketItem {
  final String movieTitle;
  final double ticketPrice;
  final String screeningDate;
  int quantity;

  BasketItem({
    required this.movieTitle,
    required this.ticketPrice,
    this.screeningDate = '',
    this.quantity = 1,
  });

  double get totalPrice => ticketPrice * quantity;
}
