import 'package:coffee_shop_managementt/data/models/product_model.dart';
import 'package:coffee_shop_managementt/main.dart';
import 'package:coffee_shop_managementt/presentation/controllers/manage_products_controller.dart';
import 'package:coffee_shop_managementt/presentation/widgets/manage_products/add_product_dialog.dart';
import 'package:coffee_shop_managementt/presentation/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ManageProductsScreen extends StatelessWidget {
  ManageProductsScreen({
    super.key, // ignore: unused_element
  });

  ManageProductsController manageProductsController = Get.find();

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Manage your products'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _openDialogForAddingProduct(context);
            },
            child: Icon(Icons.add),
          ),
          body: GetBuilder<ManageProductsController>(
            builder: (controller) => SizedBox(
              height: size.height,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text('Your products'),
                  ),
                  manageProductsController.products.isEmpty
                      ? Center(
                          child: Text('No products added yet'),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: manageProductsController.products.length,
                            itemBuilder: (context, index) {
                              final product =
                                  manageProductsController.products[index];
                              return ProductTile(
                                product: product,
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    if (product.id != null) {
                                      controller.deleteProduct(product.id!);
                                    } else {
                                      Get.snackbar(
                                          'Error', 'Product ID missing');
                                    }
                                  },
                                ),
                                onDelete: () => manageProductsController
                                    .deleteProduct(product.id!),
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      );

  void _openDialogForAddingProduct(BuildContext context) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AddProductDialog(
        nameController: nameController,
        priceController: priceController,
        onSave: () {
          final name = nameController.text.trim();
          final price = double.tryParse(priceController.text.trim());

          if (name.isNotEmpty && price != null) {
            Product product = Product(name: name, price: price);
            // Assuming StartDayController has an addProduct method with price
            manageProductsController.addProduct(product);
            Navigator.pop(context);
          } else {
            Get.snackbar('Error', 'Please fill all fields correctly');
          }
        },
        onCancel: () => Navigator.pop(context),
      ),
    );
  }
}
