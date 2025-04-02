import 'package:coffee_shop_managementt/data/datasources/db_helper.dart';
import 'package:coffee_shop_managementt/data/repos_imp/product_repo_imp.dart';
import 'package:coffee_shop_managementt/data/repos_imp/session_repo_imp.dart';
import 'package:coffee_shop_managementt/domain/repo/product_repo.dart';
import 'package:coffee_shop_managementt/domain/repo/session_history.dart';
import 'package:coffee_shop_managementt/presentation/controllers/end_day_controller.dart';
import 'package:coffee_shop_managementt/presentation/controllers/home_controller.dart';
import 'package:coffee_shop_managementt/presentation/controllers/manage_products_controller.dart';
import 'package:coffee_shop_managementt/presentation/controllers/session_controller.dart';
import 'package:coffee_shop_managementt/presentation/controllers/start_day_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DatabaseHelper>(
      () => DatabaseHelper.instance,
      fenix: true,
    );
    Get.lazyPut<ProductRepository>(
      () => ProductRepositoryImpl(
        Get.find<DatabaseHelper>(),
      ),
      fenix: true,
    );
    Get.lazyPut<StartDayController>(
      () => StartDayController(
        Get.find<ProductRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<ManageProductsController>(
      () => ManageProductsController(
        Get.find<ProductRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<EndDayController>(
      () => EndDayController(
        Get.find<ProductRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<HomeController>(
      () => HomeController(
        Get.find<ProductRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<SessionRepository>(
      () => SessionRepositoryImp(
        Get.find<DatabaseHelper>(),
      ),
      fenix: true,
    );
    Get.lazyPut<SessionController>(
      () => SessionController(
        Get.find<SessionRepository>(),
      ),
      fenix: true,
    );
  }
}
