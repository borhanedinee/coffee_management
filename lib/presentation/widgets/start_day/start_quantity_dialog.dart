// lib/presentation/widgets/start_day/start_quantity_dialog.dart
import 'package:coffee_shop_managementt/core/constants/app_strings.dart';
import 'package:coffee_shop_managementt/core/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class StartQuantityDialog extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  final String productName;

  StartQuantityDialog({super.key, required this.productName});

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
            Text(productName, style: Theme.of(context).textTheme.bodyMedium),
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
                        Navigator.of(context).pop(quantity);
                      } else {
                        Get.snackbar('title', 'enter a valid number');
                      }
                    } else {
                      Get.snackbar('title', 'quantity should not be empty');
                    }
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
