import 'package:coffee_shop_managementt/data/models/product_model.dart';
import 'package:coffee_shop_managementt/domain/repo/product_repo.dart';
import 'package:get/get.dart';

class ManageProductsController extends GetxController {
  ProductRepository productRepository;
  ManageProductsController(this.productRepository);

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  List<Product> products = [];
  getProducts() async {
    products = await productRepository.getProducts();
    update();
  }

  // add product
  addProduct(Product product) async {
    await productRepository.addProduct(product);
    getProducts();
  }

  // delete product
  deleteProduct(int id) async {
    await productRepository.deleteProduct(id);
    getProducts();
  }
}
