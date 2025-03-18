// lib/domain/repositories/product_repository.dart
import 'package:coffee_shop_managementt/data/models/product_model.dart';

abstract class ProductRepository {
  Future<void> addProduct(Product product);
  Future<List<Product>> getProducts();
  Future<List<Product>> searchProducts(String pattern);
  Future<int> deleteProduct(int id);
}
