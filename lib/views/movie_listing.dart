import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/models/movie.dart';

class MovieListing extends StatefulWidget {
  final Movie movie;

  const MovieListing({super.key, required this.movie});

  @override
  State<MovieListing> createState() => _MovieListingState();
}

class _MovieListingState extends State<MovieListing> {
  int _quantity = 0;
  String _message = '';

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: cinemaHeaderStyle),
        backgroundColor: cinemaSurface,
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,
      ),
      drawer: const NavDrawer(),
      body: Container(
        color: cinemaBackground,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // Movie poster
              Image.asset(
                movie.image,
                width: 225,
                height: 335,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 24),

              // Cinema room
              const Text(
                'Southsea Cinema Room',
                style: TextStyle(
                  color: cinemaFontWhite,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),

              // Screening date and time
              Text(
                movie.screeningDate,
                style: const TextStyle(
                  color: cinemaFontWhite,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                '${movie.title} (${movie.year}) (${movie.ageRating})',
                style: const TextStyle(
                  color: cinemaFontWhite,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Runtime: ${movie.runtime}',
                style: const TextStyle(
                  color: cinemaFontWhite,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 40),
              const SizedBox(height: 40),
              Text(
                movie.description,
                style: const TextStyle(
                  color: cinemaFontWhite,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Please note that Discounts / Membership Benefits will be applied once you have selected your tickets',
                style: const TextStyle(
                  color: cinemaFontWhite,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Select Quantities (Up to 5 in total)',
                style: const TextStyle(
                  color: cinemaFontWhite,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Tickets',
                style: const TextStyle(
                  color: cinemaFontWhite,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 600) {
                    return Row(
                      children: [
                        DropdownMenu<int>(
                          initialSelection: 0,
                          onSelected: (int? value) {
                            if (value != null) {
                              setState(() {
                                _quantity = value;
                              });
                            }
                          },
                          dropdownMenuEntries: [
                            DropdownMenuEntry(value: 0, label: '0'),
                            DropdownMenuEntry(value: 1, label: '1'),
                            DropdownMenuEntry(value: 2, label: '2'),
                            DropdownMenuEntry(value: 3, label: '3'),
                            DropdownMenuEntry(value: 4, label: '4'),
                            DropdownMenuEntry(value: 5, label: '5'),
                          ],
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'Adult (£7.50)',
                          style: TextStyle(
                            color: cinemaFontWhite,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 40),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _message =
                                  '$_quantity tickets added to the order';
                            });
                          },
                          child: const Text('Add to order'),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            DropdownMenu<int>(
                              initialSelection: 0,
                              onSelected: (int? value) {
                                if (value != null) {
                                  setState(() {
                                    _quantity = value;
                                  });
                                }
                              },
                              dropdownMenuEntries: [
                                DropdownMenuEntry(value: 0, label: '0'),
                                DropdownMenuEntry(value: 1, label: '1'),
                                DropdownMenuEntry(value: 2, label: '2'),
                                DropdownMenuEntry(value: 3, label: '3'),
                                DropdownMenuEntry(value: 4, label: '4'),
                                DropdownMenuEntry(value: 5, label: '5'),
                              ],
                            ),
                            const SizedBox(width: 16),
                            const Text(
                              'Adult (£7.50)',
                              style: TextStyle(
                                color: cinemaFontWhite,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _message =
                                  '$_quantity tickets added to the order';
                            });
                          },
                          child: const Text('Add to order'),
                        ),
                      ],
                    );
                  }
                },
              ),
              Text(
                _message,
                style: const TextStyle(
                  color: cinemaFontWhite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
