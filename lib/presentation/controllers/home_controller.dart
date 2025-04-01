import 'package:coffee_shop_managementt/data/models/product_model.dart';
import 'package:coffee_shop_managementt/domain/repo/product_repo.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  ProductRepository productRepository;
  HomeController(this.productRepository);

  // checking if there is any product already in session ro controll view of end day card
  bool isThereProductsInSessions = false;
  Future<void> fetchProductsInSession() async {
    try {
      isThereProductsInSessions =
          (await productRepository.getProductsThatHasStartQuantity())
              .isNotEmpty;
      update();
    } catch (e) {
      print(e);
    }
  }
}
