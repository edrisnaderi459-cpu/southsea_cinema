import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cinemaSurface,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              movie.image,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              '${movie.title} (${movie.year}) (${movie.ageRating})',
              style: cinemaHeaderStyle,
            ),
            const SizedBox(height: 8),
            Text(
              movie.description,
              style: const TextStyle(
                color: cinemaFontWhite,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Screening time: 7:30 PM',
              style: TextStyle(
                color: cinemaFontMuted,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Book'),
            ),
          ],
        ),
      ),
    );
  }
}