import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

class BasketView extends StatefulWidget {
  const BasketView({super.key});

  @override
  State<BasketView> createState() => _BasketViewState();
}

class _BasketViewState extends State<BasketView> {
  String _message = '';

  final double serviceCharge = 4.00;

  @override
  Widget build(BuildContext context) {
    final basket = BasketRepository.instance;
    final List<BasketItem> items = basket.items;

    final double charge = items.isEmpty ? 0 : serviceCharge;
    final double totalDue = basket.total + charge;

    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      drawer: const NavDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'MY ORDER',
              style: TextStyle(
                color: cinemaFontWhite,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            if (items.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    'Your basket is empty',
                    style: TextStyle(
                      color: cinemaFontWhite,
                      fontSize: 18,
                    ),
                  ),
                ),
              )
            else ...[
              const Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Item',
                      style: TextStyle(
                        color: cinemaFontWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      'Details',
                      style: TextStyle(
                        color: cinemaFontWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Price',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: cinemaFontWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              for (final item in items) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        '${item.quantity} Tickets',
                        style: const TextStyle(
                          color: cinemaBrand,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 4,
                      child: Text(
                        '${item.quantity} Standard\n'
                        '${item.movieTitle}, ${item.screeningDate}, '
                        'Southsea Cinema Room',
                        style: const TextStyle(
                          color: cinemaFontWhite,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Text(
                          '£${item.totalPrice.toStringAsFixed(2)}',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: cinemaFontWhite,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: cinemaFontWhite,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: cinemaBrand,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          basket.removeAllTickets(
                            item.movieTitle,
                            item.screeningDate,
                          );
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
              const Divider(color: cinemaSurface),
              _buildTotalRow(
                'Service Charge',
                '£${charge.toStringAsFixed(2)}',
              ),
              const SizedBox(height: 12),
              _buildTotalRow(
                'Total Due',
                '£${totalDue.toStringAsFixed(2)}',
                bold: true,
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      label: 'UPDATE ORDER',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: PrimaryButton(
                      label: 'BUY TICKETS',
                      onPressed: () {
                        setState(() {
                          basket.clearBasket();
                          _message = 'Thank you for your order!';
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
            if (_message.isNotEmpty) ...[
              const SizedBox(height: 20),
              Text(
                _message,
                style: const TextStyle(
                  color: cinemaFontWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTotalRow(
    String label,
    String value, {
    bool bold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: cinemaFontWhite,
            fontSize: bold ? 22 : 18,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: cinemaFontWhite,
            fontSize: bold ? 22 : 18,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
