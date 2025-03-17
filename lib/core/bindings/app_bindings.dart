import 'package:coffee_shop_managementt/data/datasources/db_helper.dart';
import 'package:coffee_shop_managementt/data/repos_imp/product_repo_imp.dart';
import 'package:coffee_shop_managementt/domain/repo/product_repo.dart';
import 'package:coffee_shop_managementt/presentation/controllers/manage_products_controller.dart';
import 'package:coffee_shop_managementt/presentation/controllers/start_day_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DatabaseHelper>(
      () => DatabaseHelper.instance,
    );
    Get.lazyPut<ProductRepository>(
      () => ProductRepositoryImpl(
        Get.find<DatabaseHelper>(),
      ),
    );
    Get.lazyPut<StartDayController>(
      () => StartDayController(
        Get.find<ProductRepository>(),
      ),
    );
    Get.lazyPut<ManageProductsController>(
      () => ManageProductsController(
        Get.find<ProductRepository>(),
      ),
    );
  }
}
