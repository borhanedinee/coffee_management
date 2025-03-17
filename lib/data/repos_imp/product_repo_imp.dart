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
}
