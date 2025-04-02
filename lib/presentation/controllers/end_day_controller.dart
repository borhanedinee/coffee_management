import 'package:coffee_shop_managementt/data/models/product_model.dart';
import 'package:coffee_shop_managementt/domain/repo/product_repo.dart';
import 'package:get/get.dart';

class EndDayController extends GetxController {
  ProductRepository productRepository;
  EndDayController(this.productRepository);

  List<Product> productsWithStartQuantity = [];
  bool isFetchingProductsLoading = false;
  getProductsWithStartQuantity() async {
    try {
      print(isSubmitButtonClickable);
      productsWithStartQuantity.clear();
      isFetchingProductsLoading = true;
      update();

      await Future.delayed(Duration(milliseconds: 300));

      productsWithStartQuantity =
          await productRepository.getProductsThatHasStartQuantity();
      print(productsWithStartQuantity.first.endQuantity);

      updateSubmitButtonState();
      print(isSubmitButtonClickable);

      isFetchingProductsLoading = false;
      update();
    } catch (e) {
      Get.snackbar('Error fetching end day products', e.toString());
      isFetchingProductsLoading = false;
      update();
    }
  }

  // update product end quantity
  updateProductEndQuantity(int id, int? quantity) async {
    try {
      await productRepository.updateProductEndQuantity(id, quantity);
      getProductsWithStartQuantity(); // to display the product end quantity UI UPDATE
      Get.snackbar('Success', 'Product end quantity updated successfully');
    } catch (e) {
      Get.snackbar('Error updating product end quantity', e.toString());
    }
  }

  // end day submission
  bool isSubmitButtonClickable = false;
  updateSubmitButtonState() {
    isSubmitButtonClickable = productsWithStartQuantity.any(
      (product) => product.endQuantity != null,
    );
    update();
  }

  // calculating day session things
  double actualSoldPrice = 0;
  double soldPrice = 0;
  double tolerenceValue = 0;
  bool isProcessingEndDay = false;
  calculateActualSoldPrice(double start, double end, double tolerence) async {
    isProcessingEndDay = true;
    soldPrice = end - start;
    tolerenceValue = tolerence;
    actualSoldPrice = 0;
    update();

    await Future.delayed(Duration(milliseconds: 3000));

    for (var product in productsWithStartQuantity) {
      if (product.startQuantity != null && product.endQuantity != null) {
        actualSoldPrice += product.price *
            (product.startQuantity!.toInt() - product.endQuantity!.toInt());
      }
    }

    isProcessingEndDay = false;
    update();
  }

  // start price
  // end price
  // seen sold price = start - end
}
