import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Movie>? movies;
  String? error;

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  Future<void> loadMovies() async {
    try {
      final movieRepository = MovieRepository();
      final loadedMovies = await movieRepository.loadMoviesFromAsset();

      if (!mounted) return;

      setState(() {
        movies = loadedMovies;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      drawer: const NavDrawer(),
      body: error != null
          ? Center(child: Text('Error loading movies: $error'))
          : movies == null
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: movies!.length,
                  itemBuilder: (context, index) {
                    return MovieCard(
                      movie: movies![index],
                    );
                  },
                ),
    );
  }
}
