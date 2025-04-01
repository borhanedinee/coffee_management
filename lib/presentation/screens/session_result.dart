// Screen
import 'package:coffee_shop_managementt/presentation/controllers/end_day_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SessionResultScreen extends StatelessWidget {
  const SessionResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final EndDayController controller = Get.find<EndDayController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Results'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<EndDayController>(
          builder: (controller) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              _buildResultCard(
                title: 'Sold Price',
                value: '${controller.soldPrice.toStringAsFixed(2)} DA',
                color: Colors.blue.shade100,
              ),
              const SizedBox(height: 16),
              _buildResultCard(
                title: 'Actual Sold Price',
                value: '${controller.actualSoldPrice.toStringAsFixed(2)} DA',
                color: Colors.green.shade100,
              ),
              const SizedBox(height: 16),
              _buildSuspicionCard(controller),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Get.back(); // Example action to close screen
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for result cards
  Widget _buildResultCard({
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method for suspicion card
  Widget _buildSuspicionCard(EndDayController controller) {
    final isSuspicious = controller.actualSoldPrice > controller.soldPrice;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: isSuspicious ? Colors.red.shade100 : Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Suspicious?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Icon(
                  isSuspicious ? Icons.warning : Icons.check_circle,
                  color: isSuspicious ? Colors.red : Colors.green,
                ),
                const SizedBox(width: 8),
                Text(
                  isSuspicious ? 'Yes' : 'No',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isSuspicious ? Colors.red : Colors.green,
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
