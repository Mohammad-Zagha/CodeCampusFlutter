import 'dart:convert';

class Product {
  final String id;
  final String name;
  final int price;
  final String category;
  final String description;
  final int stockQuantity;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.stockQuantity,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      description:json['description'],
      price: json['price'],
      category: json['category'],
      stockQuantity: json['stockQuantity'],
      image: json['image'],
    );
  }
}
