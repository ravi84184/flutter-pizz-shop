import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../repositories/mock_product_repository.dart';
import 'category_filter.dart';
import 'product_card.dart';

class MainContent extends StatefulWidget {
  final bool isMobile;

  const MainContent({
    super.key,
    this.isMobile = false,
  });

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  final _productRepository = MockProductRepository();
  String? _selectedCategoryId;
  List<Product> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() => _isLoading = true);
    try {
      if (_selectedCategoryId == null) {
        _products = await _productRepository.getProducts();
      } else {
        _products = await _productRepository
            .getProductsByCategory(_selectedCategoryId!);
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _handleCategorySelected(String? categoryId) {
    setState(() => _selectedCategoryId = categoryId);
    _loadProducts();
  }

  int _getGridCrossAxisCount(double width) {
    if (width > 1500) return 5;
    if (width > 1100) return 4;
    if (width > 900) return 3;
    if (width > 800) return 2;
    return 1;
  }

  double _getGridAspectRatio(double width) {
    if (widget.isMobile) return 2;
    if (width > 1500) return 0.85;
    if (width > 1100) return 0.9;
    if (width > 900) return 0.85;
    if (width > 800) return 1;
    return 1.6;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: widget.isMobile ? 16 : 24,
          ),
          child: CategoryFilter(
            selectedCategoryId: _selectedCategoryId,
            onCategorySelected: _handleCategorySelected,
          ),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _products.isEmpty
                  ? Center(
                      child: Text(
                        'No products found',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                    )
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        final horizontalPadding = widget.isMobile ? 16.0 : 24.0;
                        final crossAxisCount =
                            _getGridCrossAxisCount(constraints.maxWidth);
                        final aspectRatio =
                            _getGridAspectRatio(constraints.maxWidth);

                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding),
                          child: GridView.builder(
                            padding: const EdgeInsets.only(bottom: 20),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              childAspectRatio: aspectRatio,
                              crossAxisSpacing: 24,
                              mainAxisSpacing: 24,
                            ),
                            itemCount: _products.length,
                            itemBuilder: (context, index) {
                              return ProductCard(
                                product: _products[index],
                                isMobile: widget.isMobile,
                              );
                            },
                          ),
                        );
                      },
                    ),
        ),
      ],
    );
  }
}
