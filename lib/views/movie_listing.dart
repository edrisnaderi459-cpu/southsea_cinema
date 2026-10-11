import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

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
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: cinemaSurface,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Movie title and age rating
                    Text(
                      '${movie.title} (${movie.ageRating})',
                      style: const TextStyle(
                        color: cinemaFontWhite,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Movie poster
                    Image.asset(
                      movie.image,
                      width: 160,
                      height: 240,
                      fit: BoxFit.contain,
                      alignment: Alignment.centerLeft,
                    ),

                    const SizedBox(height: 16),

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

                    const SizedBox(height: 20),

                    // Movie description
                    Text(
                      movie.description,
                      style: const TextStyle(
                        color: cinemaFontWhite,
                        fontSize: 18,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Ticket selection
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final ticketSelector = Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Tickets (£6.00 each)',
                                style: TextStyle(
                                  color: cinemaFontWhite,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            DropdownMenu<int>(
                              width: 120,
                              initialSelection: _quantity,
                              onSelected: (int? value) {
                                if (value != null) {
                                  setState(() {
                                    _quantity = value;
                                    _message = '';
                                  });
                                }
                              },
                              dropdownMenuEntries: List.generate(
                                6,
                                (index) => DropdownMenuEntry<int>(
                                  value: index,
                                  label: '$index',
                                ),
                              ),
                            ),
                          ],
                        );

                        final addButton = ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: cinemaBrand,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 14,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _message = _quantity == 0
                                  ? 'Please select at least one ticket'
                                  : '$_quantity tickets added to the order';
                            });
                          },
                          child: const Text('Add to order'),
                        );

                        if (constraints.maxWidth > 600) {
                          return Row(
                            children: [
                              Expanded(child: ticketSelector),
                              const SizedBox(width: 24),
                              addButton,
                            ],
                          );
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ticketSelector,
                            const SizedBox(height: 24),
                            addButton,
                          ],
                        );
                      },
                    ),

                    if (_message.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text(
                        _message,
                        style: const TextStyle(
                          color: cinemaFontWhite,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
