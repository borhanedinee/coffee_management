// lib/presentation/widgets/start_day/start_quantity_dialog.dart
import 'package:coffee_shop_managementt/core/constants/app_strings.dart';
import 'package:coffee_shop_managementt/core/constants/text_styles.dart';
import 'package:coffee_shop_managementt/data/models/product_model.dart';
import 'package:coffee_shop_managementt/presentation/controllers/start_day_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class StartQuantityDialog extends StatefulWidget {
  final Product product;

  StartQuantityDialog({super.key, required this.product});

  @override
  State<StartQuantityDialog> createState() => _StartQuantityDialogState();
}

class _StartQuantityDialogState extends State<StartQuantityDialog> {
  final TextEditingController controller = TextEditingController();
  StartDayController startDayController = Get.find();

  @override
  void initState() {
    if (widget.product.startQuantity != null) {
      controller.text = widget.product.startQuantity.toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 8,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppStrings.enterQuantityTitle,
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 20),
            Text(widget.product.name,
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 15),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                hintText: AppStrings.quantityHint,
                hintStyle: AppTextStyles.hint,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(AppStrings.cancel),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    final value = controller.text;
                    if (value.isNotEmpty) {
                      final quantity = int.tryParse(value);
                      if (quantity != null) {
                        startDayController.updateProductStartQuantity(
                          widget.product.id!,
                          quantity,
                        );
                        Get.back();
                      } else {
                        Get.snackbar('title', 'enter a valid number');
                      }
                    } else {
                      Get.snackbar('title', 'quantity should not be empty');
                    }
                  },
                  child: Text(AppStrings.save),
                ),
                const SizedBox(width: 10),
                if (widget.product.startQuantity != null)
                  ElevatedButton(
                    onPressed: () async {
                      await startDayController.updateProductStartQuantity(
                        widget.product.id!,
                        null,
                      );
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      AppStrings.clear,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
