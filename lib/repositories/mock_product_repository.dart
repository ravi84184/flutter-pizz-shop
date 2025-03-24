import '../models/product.dart';
import '../data/sample_data.dart';
import 'product_repository.dart';

class MockProductRepository implements ProductRepository {

  @override
  Future<List<Product>> getProducts() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return SampleData.products;
  }

  @override
  Future<List<Product>> getProductsByCategory(String categoryId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return SampleData.products
        .where((product) => product.category.id == categoryId)
        .toList();
  }

  @override
  Future<Product?> getProductById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return SampleData.products.firstWhere((product) => product.id == id);
  }
} 