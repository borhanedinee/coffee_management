import 'package:coffee_shop_managementt/core/constants/app_colors.dart';
import 'package:coffee_shop_managementt/core/constants/app_strings.dart';
import 'package:coffee_shop_managementt/presentation/controllers/end_day_controller.dart';
import 'package:coffee_shop_managementt/presentation/widgets/end_day/ed_day_searchbar.dart';
import 'package:coffee_shop_managementt/presentation/widgets/end_day/end_quantity_dialog.dart';
import 'package:coffee_shop_managementt/presentation/widgets/end_day/submit_button.dart';
import 'package:coffee_shop_managementt/presentation/widgets/product_tile.dart';
import 'package:coffee_shop_managementt/presentation/widgets/start_day/start_quantity_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EndDayScreen extends StatefulWidget {
  EndDayScreen({
    super.key, // ignore: unused_element
  });

  @override
  State<EndDayScreen> createState() => _EndDayScreenState();
}

class _EndDayScreenState extends State<EndDayScreen> {
  EndDayController endDayController = Get.find();

  @override
  void initState() {
    endDayController.getProductsWithStartQuantity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text(AppStrings.endDayTitle)),
          body: GetBuilder<EndDayController>(
            builder: (controller) => Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        AppStrings.endDayInstructionText,
                      ),
                    ),
                    const EndDaySearchBar(),
                    endDayController.isFetchingProductsLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : endDayController.productsWithStartQuantity.isEmpty
                            ? Center(
                                child:
                                    Text(AppStrings.endDayNoProductsFoundText),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: endDayController
                                      .productsWithStartQuantity.length,
                                  itemBuilder: (context, index) {
                                    final product = endDayController
                                        .productsWithStartQuantity[index];
                                    return ProductTile(
                                      product: product,
                                      onTap: () => showDialog(
                                        context: context,
                                        builder: (_) => EndQuantityDialog(
                                          product: product,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                  ],
                ),
                Positioned(
                  right: 20,
                  left: 20,
                  bottom: 5,
                  child: SubmitEndDayButton(),
                ),
              ],
            ),
          ),
        ),
      );
}
