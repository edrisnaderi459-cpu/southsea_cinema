import 'package:southsea_cinema/models/movie.dart';

class MovieRepository {
  List<Movie> getMovies() {
    return [
      const Movie(
        id: 'interstellar',
        title: 'Interstellar',
        year: 2014,
        ageRating: '12A',
        runtime: '2h 49m',
        description:
            'A team of astronauts travel through a wormhole in space in search of a new home for humanity.',
        image: 'assets/images/interstellar.jpeg',
      ),
      const Movie(
        id: 'spiderman',
        title: 'Spider-Man',
        year: 2002,
        ageRating: '12A',
        runtime: '2h 1m',
        description:
            'A teenager gains spider-like abilities and uses them to fight crime and protect the people he cares about.',
        image: 'assets/images/spiderman.jpeg',
      ),
    ];
  }
}