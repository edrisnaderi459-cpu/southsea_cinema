import 'package:flutter/material.dart';

import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/views/movie_listing.dart';

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
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie information
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Poster
                SizedBox(
                  width: 120,
                  height: 180,
                  child: Image.asset(
                    movie.image,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 16),

                // Movie details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${movie.title} (${movie.year})',
                        style: cinemaHeaderStyle,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '(${movie.ageRating})',
                        style: const TextStyle(
                          color: cinemaFontMuted,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        movie.description,
                        style: const TextStyle(
                          color: cinemaFontWhite,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // Booking section
            const Text(
              'BOOK TICKETS',
              style: TextStyle(
                color: cinemaFontWhite,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 18),

            // Responsive date and button
            LayoutBuilder(
              builder: (context, constraints) {
                // PHONE
                if (constraints.maxWidth < 600) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.screeningDate,
                        style: const TextStyle(
                          color: cinemaFontWhite,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MovieListing(movie: movie),
                              ),
                            );
                          },
                          child: const Text('BOOK NOW'),
                        ),
                      ),
                    ],
                  );
                }

                // TABLET / DESKTOP
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      movie.screeningDate,
                      style: const TextStyle(
                        color: cinemaFontWhite,
                        fontSize: 16,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieListing(movie: movie),
                          ),
                        );
                      },
                      child: const Text('BOOK NOW'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
