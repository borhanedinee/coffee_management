// lib/presentation/controllers/start_day_controller.dart
import 'package:coffee_shop_managementt/data/datasources/db_helper.dart';
import 'package:coffee_shop_managementt/data/models/product_model.dart';
import 'package:coffee_shop_managementt/data/repos_imp/product_repo_imp.dart';
import 'package:coffee_shop_managementt/domain/repo/product_repo.dart';
import 'package:coffee_shop_managementt/presentation/controllers/home_controller.dart';
import 'package:get/get.dart';

class StartDayController extends GetxController {
  final ProductRepository productRepository;

  StartDayController(this.productRepository);

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  final List<Product> products = <Product>[];
  bool isFetchingProducts = false;
  Future<void> getProducts() async {
    try {
      products.clear();
      isFetchingProducts = true;
      update();
      await Future.delayed(
        Duration(milliseconds: 300),
      );

      final fetchedProducts = await productRepository.getProducts();
      products.assignAll(fetchedProducts);
      isFetchingProducts = false;
      update();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load products: $e');
      isFetchingProducts = false;
      update();
    }
  }

  // search for products
  List<Product> searchedProducts = [];
  bool isSearchLoading = false;
  String searchPattern = ''; // to show empty search products
  searchProducts(String pattern) async {
    try {
      searchPattern = pattern;
      searchedProducts.clear();
      isSearchLoading = true;
      update();

      await Future.delayed(
        Duration(milliseconds: 300),
      );

      searchedProducts = await productRepository.searchProducts(pattern);
      isSearchLoading = false;

      update();
    } catch (e) {
      Get.snackbar('Error', 'Failed to search products');
      isSearchLoading = false;

      update();
    }
  }

  clearSearchedProducts() {
    searchedProducts.clear();
    update();
  }

  // update product start quantity
  updateProductStartQuantity(int id, int? quantity) async {
    try {
      await productRepository.updateProductStartQuantity(id, quantity);
      Get.snackbar('Success', 'Product updated successfully');
      await Get.find<HomeController>().fetchProductsInSession();
      await getProducts();
    } catch (e) {
      Get.snackbar('Error', 'Failed to update product: $e');
    }
  }
}
