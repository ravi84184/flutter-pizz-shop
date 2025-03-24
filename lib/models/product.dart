import 'category.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String size;
  final Category category;
  final List<String> ingredients;
  final int preparationTime;
  final double rating;
  final int ratingCount;
  final bool isSpicy;
  final bool isVegetarian;
  final bool isBestSeller;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.size,
    required this.category,
    required this.ingredients,
    required this.preparationTime,
    this.rating = 0.0,
    this.ratingCount = 0,
    this.isSpicy = false,
    this.isVegetarian = false,
    this.isBestSeller = false,
  });

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    String? size,
    Category? category,
    List<String>? ingredients,
    int? preparationTime,
    double? rating,
    int? ratingCount,
    bool? isSpicy,
    bool? isVegetarian,
    bool? isBestSeller,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      size: size ?? this.size,
      category: category ?? this.category,
      ingredients: ingredients ?? this.ingredients,
      preparationTime: preparationTime ?? this.preparationTime,
      rating: rating ?? this.rating,
      ratingCount: ratingCount ?? this.ratingCount,
      isSpicy: isSpicy ?? this.isSpicy,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      isBestSeller: isBestSeller ?? this.isBestSeller,
    );
  }
} 