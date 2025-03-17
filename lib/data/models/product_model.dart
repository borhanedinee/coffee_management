// lib/data/models/product_model.dart
class Product {
  final int? id;
  final String name;
  final int? startQuantity; // Now nullable
  final double price; // New attribute

  Product({
    this.id,
    required this.name,
    this.startQuantity, // Nullable, no default
    required this.price, // Required field
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'startQuantity': startQuantity, // Can be null
        'price': price,
      };

  factory Product.fromMap(Map<String, dynamic> map) => Product(
        id: map['id'],
        name: map['name'],
        startQuantity: map['startQuantity'], // Handles null from DB
        price: map['price'],
      );
}
