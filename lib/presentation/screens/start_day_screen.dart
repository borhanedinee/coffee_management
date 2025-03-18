import 'package:coffee_shop_managementt/core/constants/app_colors.dart';
import 'package:coffee_shop_managementt/core/constants/app_strings.dart';
import 'package:coffee_shop_managementt/data/models/product_model.dart';
import 'package:coffee_shop_managementt/main.dart';
import 'package:coffee_shop_managementt/presentation/controllers/start_day_controller.dart';
import 'package:coffee_shop_managementt/presentation/screens/manage_products_screen.dart';
import 'package:coffee_shop_managementt/presentation/widgets/product_tile.dart';
import 'package:coffee_shop_managementt/presentation/widgets/start_day/empty_stock.dart';
import 'package:coffee_shop_managementt/presentation/widgets/start_day/start_quantity_dialog.dart';
import 'package:coffee_shop_managementt/presentation/widgets/start_day/custom_searchbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartDayScreen extends StatelessWidget {
  StartDayScreen({super.key});

  StartDayController startDayController = Get.find<StartDayController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Start Day Session')),
        body: GetBuilder<StartDayController>(
          builder: (controller) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(AppStrings.instructionText),
              ),
              const CustomSearchBar(),
              startDayController.isSearchLoading ||
                      startDayController.isFetchingProducts
                  ? Center(child: CircularProgressIndicator())
                  : startDayController.products.isEmpty
                      ? EmptyStock()
                      : startDayController.searchPattern == ''
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: startDayController.products.length,
                                itemBuilder: (context, index) {
                                  final product =
                                      startDayController.products[index];
                                  return ProductTile(
                                    isFromStartDay: true,
                                    product: product,
                                    onTap: () => showDialog(
                                      context: context,
                                      builder: (_) => StartQuantityDialog(
                                        productName: product.name,
                                      ),
                                    ).then((value) {
                                      if (value != null) {
                                        print('Start Quantity: $value');
                                        // Optionally update product with new quantity
                                        // controller.updateProduct(product.id!, value);
                                      }
                                    }),
                                  );
                                },
                              ),
                            )
                          : startDayController.searchedProducts.isEmpty
                              ? Center(
                                  child: Text('No products found'),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                    itemCount: startDayController
                                        .searchedProducts.length,
                                    itemBuilder: (context, index) {
                                      final product = startDayController
                                          .searchedProducts[index];
                                      return ProductTile(
                                        isFromStartDay: true,
                                        product: product,
                                        onTap: () => showDialog(
                                          context: context,
                                          builder: (_) => StartQuantityDialog(
                                            productName: product.name,
                                          ),
                                        ).then((value) {
                                          if (value != null) {
                                            print('Start Quantity: $value');
                                            // Optionally update product with new quantity
                                            // controller.updateProduct(product.id!, value);
                                          }
                                        }),
                                      );
                                    },
                                  ),
                                ),
            ],
          ),
        ),
      ),
    );
  }
}
