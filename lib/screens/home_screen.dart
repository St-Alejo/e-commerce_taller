import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'detail_screen.dart';

/// Home screen that displays the product catalog as a 2-column grid.
class HomeScreen extends StatefulWidget {
  /// Shared cart list passed down from main so state persists across screens.
  final List<Product> cart;

  const HomeScreen({super.key, required this.cart});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Navigate to the Product Detail screen for the tapped product.
  void _openDetail(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailScreen(product: product, cart: widget.cart),
      ),
    ).then((_) => setState(() {})); // Refresh cart badge on return
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Shop Motorcicle',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color(0xFF111827),
            letterSpacing: -0.5,
          ),
        ),
        actions: [
          // Cart icon with item count badge
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                if (widget.cart.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Your cart is empty.')),
                  );
                  return;
                }
                Navigator.pushNamed(context, '/checkout');
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.shopping_bag_outlined,
                      color: Color(0xFF111827), size: 26),
                  if (widget.cart.isNotEmpty)
                    Positioned(
                      top: -4,
                      right: -4,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: Color(0xFF4F46E5),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${widget.cart.length}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: const Color(0xFFE5E7EB), height: 1),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            const Text(
              'Featured Products',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF374151),
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: GridView.builder(
                itemCount: sampleProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, index) {
                  final product = sampleProducts[index];
                  return ProductCard(
                    product: product,
                    onTap: () => _openDetail(product),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}