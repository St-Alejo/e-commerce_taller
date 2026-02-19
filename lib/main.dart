import 'package:flutter/material.dart';
import 'models/product.dart';
import 'screens/home_screen.dart';
import 'screens/checkout_screen.dart';

void main() {
  runApp(const ShopifyApp());
}

/// Root widget. Holds the shared in-memory cart list and defines routes.
class ShopifyApp extends StatefulWidget {
  const ShopifyApp({super.key});

  @override
  State<ShopifyApp> createState() => _ShopifyAppState();
}

class _ShopifyAppState extends State<ShopifyApp> {
  /// Shared cart persists for the lifetime of the app process.
  final List<Product> _cart = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopify Mini',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF4F46E5),
        fontFamily: 'Poppins', // Falls back to system font if unavailable
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
      ),
      // Named routes; detail screen is pushed manually via Navigator.push
      // because it needs to receive the product object directly.
      routes: {
        '/': (_) => HomeScreen(cart: _cart),
        '/checkout': (_) => CheckoutScreen(cart: _cart),
      },
    );
  }
}