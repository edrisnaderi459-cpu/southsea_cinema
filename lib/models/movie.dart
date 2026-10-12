class Movie {
  final String id;
  final String title;
  final int year;
  final String ageRating;
  final String runtime;
  final String description;
  final String image;
  final String screeningDate;
  final double price;

  const Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.ageRating,
    required this.runtime,
    required this.description,
    required this.image,
    required this.screeningDate,
    required this.price,
  });

  String get formattedPrice => '£${price.toStringAsFixed(2)}';

  bool get isChildFriendly => ageRating == 'U' || ageRating == 'PG';

  bool get isAdultOnly => ageRating == '18';
}
