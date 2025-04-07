// lib/data/repositories/product_reposit
import 'package:coffee_shop_managementt/data/datasources/db_helper.dart';
import 'package:coffee_shop_managementt/data/models/product_model.dart';
import 'package:coffee_shop_managementt/domain/repo/product_repo.dart';

class ProductRepositoryImpl implements ProductRepository {
  final DatabaseHelper dbHelper;
  ProductRepositoryImpl(this.dbHelper);

  @override
  Future<void> addProduct(Product product) async {
    await dbHelper.insertProduct(product.toMap());
  }

  @override
  Future<List<Product>> getProducts() async {
    final maps = await dbHelper.getProducts();
    return maps.map((map) => Product.fromMap(map)).toList();
  }

  @override
  Future<int> deleteProduct(int id) async {
    final result = await dbHelper.deleteProduct(id);
    return result;
  }

  @override
  Future<List<Product>> searchProducts(String pattern) async {
    final result = await dbHelper.searchProductsByName(pattern);
    return result.map((map) => Product.fromMap(map)).toList();
  }

  @override
  Future<void> updateProductStartQuantity(int id, int? quantity) async {
    await dbHelper.updateProductStartQuantity(id, quantity);
  }

  @override
  Future<List<Product>> getProductsThatHasStartQuantity() async {
    final maps = await dbHelper.getProductsThatHasStartQuantity();
    return maps.map((map) => Product.fromMap(map)).toList();
  }

  @override
  Future<void> updateProductEndQuantity(int id, int? quantity) async {
    await dbHelper.updateProductEndQuantity(id, quantity);
  }

  @override
  Future<List<Product>> productsInSession() async {
    final maps = await dbHelper.getProductsThatHasStartQuantity();
    return maps.map((map) => Product.fromMap(map)).toList();
  }

  @override
  Future<void> clearStartAndEndQuantities() {
    return dbHelper.clearStartAndEndQuantities();
  }
}
