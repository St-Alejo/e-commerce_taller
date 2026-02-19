import 'package:flutter/material.dart';
import '../models/product.dart';
import 'checkout_screen.dart';

/// Displays full product details and allows the user to add the item to cart.
class DetailScreen extends StatefulWidget {
  final Product product;
  final List<Product> cart;

  const DetailScreen({
    super.key,
    required this.product,
    required this.cart,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _addedToCart = false;

  /// Adds the product to the shared cart list.
  void _addToCart() {
    setState(() {
      widget.cart.add(widget.product);
      _addedToCart = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.product.name} added to cart!'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: const Color(0xFF4F46E5),
      ),
    );
  }

  /// Navigates to the Checkout screen.
  void _goToCheckout() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CheckoutScreen(cart: widget.cart),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: CustomScrollView(
        slivers: [
          // Large product image in the app bar area
          SliverAppBar(
            expandedHeight: 340,
            pinned: true,
            backgroundColor: Colors.white,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_rounded,
                      color: Color(0xFF111827), size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_bag_outlined,
                            color: Color(0xFF111827), size: 20),
                        onPressed:
                        widget.cart.isEmpty ? null : _goToCheckout,
                      ),
                      if (widget.cart.isNotEmpty)
                        Positioned(
                          top: 6,
                          right: 6,
                          child: Container(
                            width: 9,
                            height: 9,
                            decoration: const BoxDecoration(
                              color: Color(0xFF4F46E5),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (_, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    color: const Color(0xFFF3F4F6),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFFF3F4F6),
                  child: const Icon(Icons.image_not_supported_outlined,
                      size: 60, color: Colors.grey),
                ),
              ),
            ),
          ),

          // Product info section
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF9FAFB),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and price row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF111827),
                            height: 1.25,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEF2FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF4F46E5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Star rating (static decoration)
                  Row(
                    children: [
                      ...List.generate(
                          5,
                              (i) => const Icon(Icons.star_rounded,
                              size: 18, color: Color(0xFFFBBF24))),
                      const SizedBox(width: 6),
                      const Text('5.0',
                          style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF6B7280),
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Description label
                  const Text(
                    'About this product',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF374151),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 14.5,
                      color: Color(0xFF6B7280),
                      height: 1.65,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Feature chips (decorative)
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: const [
                      _FeatureChip(icon: Icons.local_shipping_outlined, label: 'Free Shipping'),
                      _FeatureChip(icon: Icons.replay_outlined, label: '30-Day Returns'),
                      _FeatureChip(icon: Icons.verified_outlined, label: 'Warranty'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom action buttons
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(
            24, 16, 24, MediaQuery.of(context).padding.bottom + 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Color(0x12000000), blurRadius: 12, offset: Offset(0, -4))
          ],
        ),
        child: Row(
          children: [
            // Add to Cart button
            Expanded(
              flex: 3,
              child: ElevatedButton.icon(
                onPressed: _addToCart,
                icon: Icon(
                  _addedToCart
                      ? Icons.check_circle_rounded
                      : Icons.add_shopping_cart_rounded,
                  size: 18,
                ),
                label: Text(_addedToCart ? 'Added!' : 'Add to Cart'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _addedToCart
                      ? const Color(0xFF10B981)
                      : const Color(0xFF4F46E5),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 15),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Go to Checkout button
            Expanded(
              flex: 2,
              child: OutlinedButton(
                onPressed: widget.cart.isEmpty ? null : _goToCheckout,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF4F46E5),
                  side: const BorderSide(color: Color(0xFF4F46E5), width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 14),
                ),
                child: const Text('Checkout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Small decorative chip showing a product feature.
class _FeatureChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: const Color(0xFF4F46E5)),
          const SizedBox(width: 5),
          Text(label,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF374151))),
        ],
      ),
    );
  }
}