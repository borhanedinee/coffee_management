import 'dart:ui';

import 'package:coffee_shop_managementt/core/constants/app_colors.dart';
import 'package:coffee_shop_managementt/core/constants/app_strings.dart';
import 'package:coffee_shop_managementt/presentation/controllers/home_controller.dart';
import 'package:coffee_shop_managementt/presentation/controllers/start_day_controller.dart';
import 'package:coffee_shop_managementt/presentation/widgets/home/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:coffee_shop_managementt/presentation/screens/end_day_screen.dart';
import 'package:coffee_shop_managementt/presentation/screens/manage_products_screen.dart';
import 'package:coffee_shop_managementt/presentation/screens/start_day_screen.dart';
import 'package:coffee_shop_managementt/presentation/screens/view_history_screen.dart';

class HomeScreen extends StatefulWidget {
  /// {@macro home_screen}
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Get.find<HomeController>().fetchProductsInSession();
    super.initState();
  }

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
                  GetBuilder<HomeController>(
                    builder: (controller) => CustomNavigationCard(
                      title: AppStrings.homeEndDayCard,
                      gradientColors: controller.isThereProductsInSessions
                          ? [
                              Colors.red,
                              Colors.red.withValues(alpha: .4),
                            ]
                          : [
                              Colors.grey,
                              Colors.grey,
                            ],
                      icon: Icons.stop,
                      onTap: () => controller.isThereProductsInSessions
                          ? Get.to(
                              EndDayScreen(),
                            )
                          : Get.showSnackbar(
                              GetSnackBar(
                                title: 'No products in session',
                                message:
                                    'There should be at least one product in session to end day session',
                                duration: const Duration(seconds: 2),
                              ),
                            ),
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
