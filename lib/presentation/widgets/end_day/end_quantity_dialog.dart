// lib/presentation/widgets/start_day/start_quantity_dialog.dart
import 'package:coffee_shop_managementt/core/constants/app_strings.dart';
import 'package:coffee_shop_managementt/core/constants/text_styles.dart';
import 'package:coffee_shop_managementt/data/models/product_model.dart';
import 'package:coffee_shop_managementt/presentation/controllers/end_day_controller.dart';
import 'package:coffee_shop_managementt/presentation/controllers/start_day_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class EndQuantityDialog extends StatefulWidget {
  final Product product;

  EndQuantityDialog({super.key, required this.product});

  @override
  State<EndQuantityDialog> createState() => _EndQuantityDialogState();
}

class _EndQuantityDialogState extends State<EndQuantityDialog> {
  final TextEditingController controller = TextEditingController();
  EndDayController endDayController = Get.find();

  @override
  void initState() {
    if (widget.product.endQuantity != null) {
      controller.text = widget.product.endQuantity.toString();
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
            Text(AppStrings.endDayEnterEndQuantityTitle,
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
                hintText: AppStrings.endDayEndQuantityHint,
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
                    // if value is nul => end quantity is updated to null
                    final quantity = int.tryParse(value);
                    endDayController.updateProductEndQuantity(
                      widget.product.id!,
                      quantity,
                    );
                    Navigator.of(context).pop();
                  },
                  child: Text(AppStrings.save),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
