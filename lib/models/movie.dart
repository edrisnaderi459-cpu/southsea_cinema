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

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      year: json['year'],
      ageRating: json['ageRating'],
      runtime: json['runtime'],
      description: json['description'],
      image: json['image'],
      screeningDate: json['screeningDate'],
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'year': year,
      'ageRating': ageRating,
      'runtime': runtime,
      'description': description,
      'image': image,
      'screeningDate': screeningDate,
      'price': price,
    };
  }
}
