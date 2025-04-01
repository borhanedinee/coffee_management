// lib/data/models/product_model.dart
class Product {
  final int? id;
  final String name;
  final int? startQuantity;
  final double price;
  final int? endQuantity; // New field

  Product({
    this.id,
    required this.name,
    this.startQuantity,
    required this.price,
    this.endQuantity,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'startQuantity': startQuantity,
        'price': price,
        'endQuantity': endQuantity,
      };

  factory Product.fromMap(Map<String, dynamic> map) => Product(
        id: map['id'],
        name: map['name'],
        startQuantity: map['startQuantity'],
        price: map['price'],
        endQuantity: map['endQuantity'],
      );
}
