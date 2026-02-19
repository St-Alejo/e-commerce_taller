import 'package:flutter/material.dart';
import '../models/product.dart';

/// Checkout screen showing cart items, total price, and a simulated Buy button.
class CheckoutScreen extends StatefulWidget {
  final List<Product> cart;

  const CheckoutScreen({super.key, required this.cart});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool _orderPlaced = false;

  /// Calculates the sum of all cart item prices.
  double get _subtotal =>
      widget.cart.fold(0.0, (sum, item) => sum + item.price);

  double get _shipping => widget.cart.isEmpty ? 0.0 : 9.99;
  double get _total => _subtotal + _shipping;

  /// Removes a single item from the cart at [index].
  void _removeItem(int index) {
    setState(() {
      widget.cart.removeAt(index);
    });
  }

  /// Simulates placing the order.
  void _placeOrder() {
    setState(() {
      _orderPlaced = true;
      widget.cart.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF111827)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Your Cart',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Color(0xFF111827),
            letterSpacing: -0.3,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: const Color(0xFFE5E7EB), height: 1),
        ),
      ),
      body: _orderPlaced ? _buildSuccessView() : _buildCartView(),
    );
  }

  /// Builds the order success screen.
  Widget _buildSuccessView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFD1FAE5),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_rounded,
                  size: 56, color: Color(0xFF10B981)),
            ),
            const SizedBox(height: 28),
            const Text(
              'Order Placed!',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: Color(0xFF111827),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Thank you for your purchase.\nYour items are on their way.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15, color: Color(0xFF6B7280), height: 1.6),
            ),
            const SizedBox(height: 36),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Pop back to the Home screen
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F46E5),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 16),
                ),
                child: const Text('Continue Shopping'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the cart item list and order summary.
  Widget _buildCartView() {
    if (widget.cart.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag_outlined,
                size: 72, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            const Text(
              'Your cart is empty',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B7280)),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add some products to get started.',
              style: TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
            ),
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 0,
                padding:
                const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              ),
              child: const Text('Browse Products',
                  style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Cart items list
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: widget.cart.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = widget.cart[index];
              return _CartItemTile(
                product: item,
                onRemove: () => _removeItem(index),
              );
            },
          ),
        ),

        // Order summary card
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Color(0x12000000),
                  blurRadius: 12,
                  offset: Offset(0, -4))
            ],
          ),
          padding: EdgeInsets.fromLTRB(
              24, 20, 24, MediaQuery.of(context).padding.bottom + 20),
          child: Column(
            children: [
              _SummaryRow(label: 'Subtotal', value: _subtotal),
              const SizedBox(height: 8),
              _SummaryRow(label: 'Shipping', value: _shipping),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(color: Color(0xFFE5E7EB), height: 1),
              ),
              _SummaryRow(
                  label: 'Total',
                  value: _total,
                  isTotal: true),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _placeOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F46E5),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  child: const Text('Place Order'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// A single cart item row with image, name, price, and a remove button.
class _CartItemTile extends StatelessWidget {
  final Product product;
  final VoidCallback onRemove;

  const _CartItemTile({required this.product, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              product.imageUrl,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 70,
                height: 70,
                color: const Color(0xFFF3F4F6),
                child: const Icon(Icons.image_not_supported_outlined,
                    color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 14),
          // Name and price
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF4F46E5),
                  ),
                ),
              ],
            ),
          ),
          // Remove button
          IconButton(
            onPressed: onRemove,
            icon: const Icon(Icons.delete_outline_rounded,
                color: Color(0xFFEF4444), size: 22),
            tooltip: 'Remove',
          ),
        ],
      ),
    );
  }
}

/// A label/value row used in the order summary.
class _SummaryRow extends StatelessWidget {
  final String label;
  final double value;
  final bool isTotal;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w800 : FontWeight.w500,
            color: isTotal ? const Color(0xFF111827) : const Color(0xFF6B7280),
          ),
        ),
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600,
            color:
            isTotal ? const Color(0xFF4F46E5) : const Color(0xFF374151),
          ),
        ),
      ],
    );
  }
}