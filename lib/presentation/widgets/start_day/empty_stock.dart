import 'package:coffee_shop_managementt/core/constants/app_colors.dart';
import 'package:coffee_shop_managementt/core/constants/app_strings.dart';
import 'package:coffee_shop_managementt/main.dart';
import 'package:coffee_shop_managementt/presentation/screens/manage_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyStock extends StatelessWidget {
  const EmptyStock({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 300,
      width: size.width, // Assuming size is available from MediaQuery
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryColor.withOpacity(0.1), // Subtle indigo tint
              Colors.white,
            ],
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated Icon or Illustration
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: const Icon(
                Icons.coffee,
                size: 80,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 15),
            // Stylish Text
            Text(
              AppStrings.emptyProducts, // 'Empty products'
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            // Subtle Subtitle
            Text(
              'Empty Stock!!',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            // Beautiful Elevated Button with Animation
            AnimatedScale(
              duration: const Duration(milliseconds: 300),
              scale: 1.0,
              child: ElevatedButton(
                onPressed: () => Get.to(ManageProductsScreen()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor, // Indigo
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  shadowColor: AppColors.primaryColor.withOpacity(0.4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.add_circle_outline,
                        size: 20, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      AppStrings.goToAddProducts, // 'Go to add Products'
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
