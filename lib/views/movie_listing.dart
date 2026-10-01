import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatefulWidget {
  const MovieListing({super.key});

  @override
  State<MovieListing> createState() => _MovieListingState();
}

class _MovieListingState extends State<MovieListing> {
  int _quantity = 0;
  String _message = '';

  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Interstellar (2014) (12A)',
                style: const TextStyle(
                  color: cinemaFontWhite,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Runtime: 2h 49m',
                style: const TextStyle(
                  color: cinemaFontWhite,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'A team of astronauts travel through a wormhole in space in search of a new home for humanity.',
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
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _message = '$_quantity tickets added to the order';
                      });
                    },
                    child: const Text('Add to order'),
                  ),
                ],
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
