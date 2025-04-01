import 'package:coffee_shop_managementt/core/constants/app_colors.dart';
import 'package:coffee_shop_managementt/core/constants/text_styles.dart';
import 'package:coffee_shop_managementt/presentation/controllers/start_day_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Modular search bar with animation and styling
class EndDaySearchBar extends StatefulWidget {
  const EndDaySearchBar({super.key});

  @override
  State<EndDaySearchBar> createState() => _EndDaySearchBarState();
}

class _EndDaySearchBarState extends State<EndDaySearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                onChanged: (value) {},
                decoration: InputDecoration(
                  prefixIcon:
                      const Icon(Icons.search, color: AppColors.primaryColor),
                  hintText: 'Search products to enter end quantity',
                  hintStyle: AppTextStyles.caption,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
