import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main() {
  group('MovieRepository', () {
    late MovieRepository repository;

    setUp(() {
      repository = MovieRepository();
    });

    group('getMovies', () {
      test('returns at least two movies', () {
        final movies = repository.getMovies();

        expect(movies.length, greaterThanOrEqualTo(2));
      });

      test('every movie has a non-empty unique id', () {
        final movies = repository.getMovies();
        final ids = movies.map((movie) => movie.id).toSet();

        expect(ids.length, movies.length);

        for (final movie in movies) {
          expect(movie.id.trim(), isNotEmpty);
        }
      });

      test('every movie has a non-empty title', () {
        for (final movie in repository.getMovies()) {
          expect(movie.title.trim(), isNotEmpty);
        }
      });

      test('every movie has an age rating', () {
        for (final movie in repository.getMovies()) {
          expect(movie.ageRating.trim(), isNotEmpty);
        }
      });

      test('every movie has a ticket price greater than zero', () {
        for (final movie in repository.getMovies()) {
          expect(movie.price, greaterThan(0));
        }
      });
    });

    group('getMovieById', () {
      test('returns the correct movie for an existing id', () {
        final movie = repository.getMovieById('interstellar');

        expect(movie, isNotNull);
        expect(movie!.id, 'interstellar');
        expect(movie.title, 'Interstellar');
      });

      test('returns null for a missing id', () {
        final movie = repository.getMovieById('does-not-exist');

        expect(movie, isNull);
      });
    });

    group('getMoviesByAgeRating', () {
      test('returns only movies with the requested age rating', () {
        final movies = repository.getMoviesByAgeRating('12A');

        expect(movies, isNotEmpty);

        for (final movie in movies) {
          expect(movie.ageRating, '12A');
        }
      });

      test('returns an empty list when no movies match', () {
        final movies = repository.getMoviesByAgeRating('18');

        expect(movies, isEmpty);
      });
    });

    group('getMoviesUnderPrice', () {
      test('returns only movies below the maximum price', () {
        final movies = repository.getMoviesUnderPrice(7.00);

        expect(movies, isNotEmpty);

        for (final movie in movies) {
          expect(movie.price, lessThan(7.00));
        }
      });

      test('excludes movies priced at the maximum price', () {
        final movies = repository.getMoviesUnderPrice(6.00);

        expect(movies, isEmpty);
      });

      test('returns an empty list when no movies are below the price', () {
        final movies = repository.getMoviesUnderPrice(5.00);

        expect(movies, isEmpty);
      });
    });
  });
}
