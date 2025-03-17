import 'dart:ui';

import 'package:coffee_shop_managementt/core/constants/app_colors.dart';
import 'package:coffee_shop_managementt/core/constants/app_strings.dart';
import 'package:coffee_shop_managementt/presentation/widgets/home/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:coffee_shop_managementt/presentation/screens/end_day_screen.dart';
import 'package:coffee_shop_managementt/presentation/screens/manage_products_screen.dart';
import 'package:coffee_shop_managementt/presentation/screens/start_day_screen.dart';
import 'package:coffee_shop_managementt/presentation/screens/view_history_screen.dart';

class HomeScreen extends StatelessWidget {
  /// {@macro home_screen}
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.homeTitle)),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomNavigationCard(
                    title: AppStrings.homeStartDayCard,
                    gradientColors: [
                      AppColors.primaryColor,
                      AppColors.primaryColor.withValues(alpha: .6)
                    ],
                    icon: Icons.play_arrow,
                    onTap: () => Get.to(StartDayScreen()),
                  ),
                  const SizedBox(width: 20),
                  CustomNavigationCard(
                    title: AppStrings.homeEndDayCard,
                    gradientColors: [
                      AppColors.secondryColors,
                      AppColors.secondryColors.withValues(alpha: .6)
                    ],
                    icon: Icons.stop,
                    onTap: () => Get.to(
                      const EndDayScreen(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomNavigationCard(
                    title: AppStrings.homeManageProductsCard,
                    gradientColors: [
                      Colors.green,
                      Colors.green.withValues(alpha: 0.5)
                    ],
                    icon: Icons.inventory,
                    onTap: () => Get.to(ManageProductsScreen()),
                  ),
                  const SizedBox(width: 20),
                  CustomNavigationCard(
                    title: AppStrings.homeViewHistoryCard,
                    gradientColors: [
                      Colors.purple,
                      Colors.purple.withValues(alpha: .6)
                    ],
                    icon: Icons.history,
                    onTap: () => Get.to(const ViewHistoryScreen()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
