import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../repositories/product_repository.dart';

class ProductProvider with ChangeNotifier {
  final ProductRepository repository;
  List<Product> _items = [];
  String _selectedCategory = 'Pizza';
  bool _isLoading = false;

  ProductProvider(this.repository);

  List<Product> get items => [..._items];
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _items = await repository.getProducts();
    } catch (error) {
      _items = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> filterByCategory(String category) async {
    _selectedCategory = category;
    _isLoading = true;
    notifyListeners();

    try {
      _items = await repository.getProductsByCategory(category);
    } catch (error) {
      _items = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} 