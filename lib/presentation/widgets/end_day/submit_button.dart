import 'package:coffee_shop_managementt/core/constants/app_colors.dart';
import 'package:coffee_shop_managementt/core/constants/app_strings.dart';
import 'package:coffee_shop_managementt/core/services/snackbars.dart';
import 'package:coffee_shop_managementt/presentation/controllers/end_day_controller.dart';
import 'package:coffee_shop_managementt/presentation/screens/session_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmitEndDayButton extends StatelessWidget {
  const SubmitEndDayButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EndDayController>(
      builder: (controller) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: controller.isSubmitButtonClickable
              ? AppColors.primaryColor
              : AppColors.primaryColor.shade100,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
        ),
        onPressed: () {
          if (!controller.isSubmitButtonClickable) {
            SnackbarService.show(
              message:
                  'Please add at least one producte end quantity to end day session.',
            );
            return;
          }
          // calculating day session things
          // for each product we calculate sold quantity
          // thenwe calculate the for each product price * sold quantity
          // the we sum up all the prices
          // final we display the total price
          showPriceRangeDialog(context);
        },
        child: controller.isProcessingEndDay
            ? const CircularProgressIndicator(
                backgroundColor: Colors.white,
              )
            : Text(
                AppStrings.endDaySubmitButton,
              ),
      ),
    );
  }

  void showPriceRangeDialog(BuildContext context) {
    final _startPriceController = TextEditingController();
    final _endPriceController = TextEditingController();
    final _toleranceValueController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Set Price Range'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _startPriceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Start Price',
                    hintText: 'Enter starting price',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a start price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _endPriceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'End Price',
                    hintText: 'Enter ending price',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an end price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    final startPrice =
                        double.tryParse(_startPriceController.text);
                    final endPrice = double.tryParse(value);
                    if (startPrice != null &&
                        endPrice != null &&
                        endPrice < startPrice) {
                      return 'End price must be greater than start price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _toleranceValueController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Tolerance value',
                    hintText: 'Enter tolerance value',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'tolerance value must not be null';
                    }
                    final doubleValue = double.tryParse(value);
                    if (doubleValue == null || doubleValue < 0) {
                      return 'return a valid tolerance value number';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog on cancel
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final startPrice = double.parse(_startPriceController.text);
                  final endPrice = double.parse(_endPriceController.text);
                  final tolerance =
                      double.parse(_toleranceValueController.text);
                  // Return the values and close dialog
                  Navigator.of(context).pop({
                    'start': startPrice,
                    'end': endPrice,
                    'tolerance': tolerance,
                  });
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    ).then((result) async {
      if (result != null) {
        // Handle the submitted values
        final start = result['start'];
        final end = result['end'];
        final tolerance = result['tolerance'];
        await Get.find<EndDayController>()
            .calculateActualSoldPrice(start, end, tolerance);
        Get.to(SessionResultScreen());
      }
    });
  }
}
