import 'package:coffee_shop_managementt/core/constants/app_strings.dart';
import 'package:coffee_shop_managementt/core/services/date_formats.dart';
import 'package:coffee_shop_managementt/data/models/daily_sessions_model.dart';
import 'package:coffee_shop_managementt/data/models/session_model.dart';
import 'package:coffee_shop_managementt/presentation/controllers/session_controller.dart';
import 'package:coffee_shop_managementt/presentation/widgets/history/daily_sessions_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ViewHistoryScreen extends StatefulWidget {
  const ViewHistoryScreen({
    super.key,
  });

  @override
  State<ViewHistoryScreen> createState() => _ViewHistoryScreenState();
}

class _ViewHistoryScreenState extends State<ViewHistoryScreen> {
  @override
  void initState() {
    Get.find<SessionController>().fetchPreviousSessions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.historyTitle)),
        body: GetBuilder<SessionController>(
          builder: (controller) => controller.isFetchingPreviousSessions
              ? Center(child: CircularProgressIndicator())
              : controller.gouppedDailySessions.isEmpty
                  ? Center(
                      child: Text(AppStrings.historyNoSessionsFoundText),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          controller.gouppedDailySessions.length,
                          (index) {
                            final dailySessions =
                                controller.gouppedDailySessions[index];
                            return DailySessionsCard(
                                dailySessions: dailySessions);
                          },
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
