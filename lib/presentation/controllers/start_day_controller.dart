// lib/presentation/controllers/start_day_controller.dart
import 'package:coffee_shop_managementt/data/datasources/db_helper.dart';
import 'package:coffee_shop_managementt/data/models/product_model.dart';
import 'package:coffee_shop_managementt/data/repos_imp/product_repo_imp.dart';
import 'package:coffee_shop_managementt/domain/repo/product_repo.dart';
import 'package:get/get.dart';

class StartDayController extends GetxController {
  final List<Product> products = <Product>[];

  final ProductRepository productRepository;

  StartDayController(this.productRepository);

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  Future<void> getProducts() async {
    try {
      final fetchedProducts = await productRepository.getProducts();
      products.assignAll(fetchedProducts);
      update();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load products: $e');
    }
  }
}
