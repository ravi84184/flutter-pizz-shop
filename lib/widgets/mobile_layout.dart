import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'mobile/mobile_header.dart';
import 'mobile/mobile_bottom_nav.dart';
import 'content/main_content.dart';
import 'cart/cart_sheet.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          MobileHeader(),
          Expanded(
            child: MainContent(isMobile: true),
          ),
          MobileBottomNav(),
        ],
      ),
      floatingActionButton: Consumer<CartProvider>(
        builder: (context, cart, _) => FloatingActionButton(
          onPressed: () => _showCart(context),
          backgroundColor: Theme.of(context).primaryColor,
          child: Badge(
            label: Text(cart.itemCount.toString()),
            isLabelVisible: cart.itemCount > 0,
            child: const Icon(Icons.shopping_cart, color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _showCart(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const CartSheet(),
    );
  }
} 