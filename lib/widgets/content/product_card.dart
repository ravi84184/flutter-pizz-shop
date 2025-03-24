import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../../providers/cart_provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isMobile;

  const ProductCard({
    super.key,
    required this.product,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallCard = constraints.maxWidth < 300;
        final isMediumCard = constraints.maxWidth < 400;

        return Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: isMobile
              ? _buildMobileLayout(context, constraints)
              : _buildDesktopLayout(context, isSmallCard, isMediumCard),
        );
      },
    );
  }

  Widget _buildQuantityControls(
      BuildContext context, int quantity, bool isSmall) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove, color: colorScheme.onPrimary),
            iconSize: isSmall ? 16 : 18,
            padding: EdgeInsets.all(isSmall ? 4 : 6),
            constraints: const BoxConstraints(),
            onPressed: () {
              if (quantity > 1) {
                context.read<CartProvider>().updateQuantity(
                      product.id,
                      quantity - 1,
                    );
              } else {
                context.read<CartProvider>().removeItem(product.id);
              }
            },
          ),
          Container(
            constraints: BoxConstraints(
              minWidth: isSmall ? 24 : 32,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              quantity.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontSize: isSmall ? 14 : 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add, color: colorScheme.onPrimary),
            iconSize: isSmall ? 16 : 18,
            padding: EdgeInsets.all(isSmall ? 4 : 6),
            constraints: const BoxConstraints(),
            onPressed: () {
              context.read<CartProvider>().updateQuantity(
                    product.id,
                    quantity + 1,
                  );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddToCartButton(BuildContext context, bool isSmall) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Consumer<CartProvider>(
      builder: (context, cart, _) {
        final cartItem = cart.items[product.id];
        if (cartItem != null) {
          return _buildQuantityControls(context, cartItem.quantity, isSmall);
        }
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _addToCart(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              padding: EdgeInsets.symmetric(
                vertical: isSmall ? 6 : 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Add to Cart',
              style: TextStyle(
                fontSize: isSmall ? 14 : 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context, BoxConstraints constraints) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final imageWidth = constraints.maxWidth * 0.35;
    final isSmall = constraints.maxWidth < 300;

    return Row(
      children: [
        Hero(
          tag: 'product-${product.id}',
          child: Container(
            width: imageWidth,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(20)),
              image: DecorationImage(
                image: NetworkImage(product.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (product.isSpicy)
                      const Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Icon(
                          Icons.whatshot,
                          color: Colors.red,
                          size: 18,
                        ),
                      ),
                    if (product.isVegetarian)
                      Padding(
                        padding: EdgeInsets.only(
                          left: product.isSpicy ? 8 : 4,
                        ),
                        child: const Icon(
                          Icons.eco,
                          color: Colors.green,
                          size: 18,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  product.description,
                  style: TextStyle(
                    color: colorScheme.onSurface.withOpacity(0.7),
                    fontSize: 13,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 14,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${product.preparationTime} min',
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '\$${product.price}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildAddToCartButton(context, isSmall),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(
      BuildContext context, bool isSmallCard, bool isMediumCard) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Hero(
              tag: 'product-${product.id}',
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.network(
                  product.imageUrl,
                  height: isSmallCard
                      ? 120
                      : isMediumCard
                          ? 140
                          : 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (product.isBestSeller && !isSmallCard)
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMediumCard ? 8 : 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.local_fire_department,
                        color: colorScheme.onPrimary,
                        size: isMediumCard ? 14 : 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Best Seller',
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontSize: isMediumCard ? 10 : 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: EdgeInsets.all(isMediumCard ? 6 : 8),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: theme.shadowColor.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: isMediumCard ? 14 : 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      product.rating.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: isMediumCard ? 10 : 12,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(isSmallCard ? 12 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        style: TextStyle(
                          fontSize: isSmallCard ? 16 : 18,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (product.isSpicy)
                      Icon(
                        Icons.whatshot,
                        color: Colors.red,
                        size: isSmallCard ? 18 : 20,
                      ),
                    if (product.isVegetarian)
                      Padding(
                        padding: EdgeInsets.only(
                          left: product.isSpicy ? 8 : 0,
                        ),
                        child: Icon(
                          Icons.eco,
                          color: Colors.green,
                          size: isSmallCard ? 18 : 20,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  product.description,
                  style: TextStyle(
                    color: colorScheme.onSurface.withOpacity(0.7),
                    fontSize: isSmallCard ? 12 : 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallCard ? 8 : 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: isSmallCard ? 14 : 16,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${product.preparationTime} min',
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                              fontSize: isSmallCard ? 10 : 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '\$${product.price}',
                      style: TextStyle(
                        fontSize: isSmallCard ? 18 : 20,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildAddToCartButton(context, isSmallCard),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _addToCart(BuildContext context) {
    context.read<CartProvider>().addToCart(product);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
