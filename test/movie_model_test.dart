import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {
  group('Movie model', () {
    const movie = Movie(
      id: 'interstellar',
      title: 'Interstellar',
      year: 2014,
      ageRating: '12A',
      runtime: '2h 49m',
      description: 'A team of astronauts travel through a wormhole.',
      image: 'assets/images/intersteller.jpeg',
      screeningDate: 'Sunday 4 Oct 2026 15:00',
      price: 6.00,
    );

    group('Constructor', () {
      test('assigns properties correctly', () {
        expect(movie.id, 'interstellar');
        expect(movie.title, 'Interstellar');
        expect(movie.year, 2014);
        expect(movie.ageRating, '12A');
        expect(movie.runtime, '2h 49m');
        expect(
          movie.description,
          'A team of astronauts travel through a wormhole.',
        );
        expect(movie.image, 'assets/images/intersteller.jpeg');
        expect(movie.screeningDate, 'Sunday 4 Oct 2026 15:00');
        expect(movie.price, 6.00);
      });
    });

    group('formattedPrice', () {
      test('formats the price with a pound sign and two decimal places', () {
        expect(movie.formattedPrice, '£6.00');
      });
    });

    group('isChildFriendly', () {
      test('returns true for U-rated movies', () {
        const childMovie = Movie(
          id: 'child',
          title: 'Child Movie',
          year: 2020,
          ageRating: 'U',
          runtime: '1h 30m',
          description: 'A movie for everyone.',
          image: 'child.jpeg',
          screeningDate: 'Sunday 4 Oct 2026 15:00',
          price: 6.00,
        );

        expect(childMovie.isChildFriendly, true);
      });

      test('returns true for PG-rated movies', () {
        const pgMovie = Movie(
          id: 'pg',
          title: 'PG Movie',
          year: 2020,
          ageRating: 'PG',
          runtime: '1h 30m',
          description: 'A PG-rated movie.',
          image: 'pg.jpeg',
          screeningDate: 'Sunday 4 Oct 2026 15:00',
          price: 6.00,
        );

        expect(pgMovie.isChildFriendly, true);
      });

      test('returns false for 12A-rated movies', () {
        expect(movie.isChildFriendly, false);
      });

      test('returns false for 18-rated movies', () {
        const adultMovie = Movie(
          id: 'adult',
          title: 'Adult Movie',
          year: 2020,
          ageRating: '18',
          runtime: '1h 30m',
          description: 'An adults-only movie.',
          image: 'adult.jpeg',
          screeningDate: 'Sunday 4 Oct 2026 15:00',
          price: 6.00,
        );

        expect(adultMovie.isChildFriendly, false);
      });
    });

    group('isAdultOnly', () {
      test('returns true for 18-rated movies', () {
        const adultMovie = Movie(
          id: 'adult',
          title: 'Adult Movie',
          year: 2020,
          ageRating: '18',
          runtime: '1h 30m',
          description: 'An adults-only movie.',
          image: 'adult.jpeg',
          screeningDate: 'Sunday 4 Oct 2026 15:00',
          price: 6.00,
        );

        expect(adultMovie.isAdultOnly, true);
      });

      test('returns false for U-rated movies', () {
        const childMovie = Movie(
          id: 'child',
          title: 'Child Movie',
          year: 2020,
          ageRating: 'U',
          runtime: '1h 30m',
          description: 'A movie for everyone.',
          image: 'child.jpeg',
          screeningDate: 'Sunday 4 Oct 2026 15:00',
          price: 6.00,
        );

        expect(childMovie.isAdultOnly, false);
      });

      test('returns false for PG-rated movies', () {
        const pgMovie = Movie(
          id: 'pg',
          title: 'PG Movie',
          year: 2020,
          ageRating: 'PG',
          runtime: '1h 30m',
          description: 'A PG-rated movie.',
          image: 'pg.jpeg',
          screeningDate: 'Sunday 4 Oct 2026 15:00',
          price: 6.00,
        );

        expect(pgMovie.isAdultOnly, false);
      });

      test('returns false for 12A-rated movies', () {
        expect(movie.isAdultOnly, false);
      });
    });
  });
}
