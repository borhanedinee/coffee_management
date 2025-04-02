// Screen
import 'package:coffee_shop_managementt/core/services/snackbars.dart';
import 'package:coffee_shop_managementt/data/models/session_model.dart';
import 'package:coffee_shop_managementt/main.dart';
import 'package:coffee_shop_managementt/presentation/controllers/end_day_controller.dart';
import 'package:coffee_shop_managementt/presentation/controllers/session_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SessionResultScreen extends StatelessWidget {
  const SessionResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller

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
                title: 'Price of today f la caisse',
                value: '${controller.soldPrice.toStringAsFixed(2)} DA',
                color: Colors.blue.shade100,
              ),
              const SizedBox(height: 16),
              _buildResultCard(
                title: 'Price of today calculated by the app',
                value: '${controller.actualSoldPrice.toStringAsFixed(2)} DA',
                color: Colors.green.shade100,
              ),
              const SizedBox(height: 16),
              _buildSuspicionCard(controller),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  // Show the dialog and wait for the result
                  final result = await showSessionDetailsDialog(context);

                  // If the user cancels the dialog, result will be null
                  if (result != null) {
                    final SessionPeriod period = result['period'];
                    final DateTime sessionDate = result['sessionDate'];

                    // Create the SessionModel object
                    final session = SessionModel(
                      priceInCaisse: controller.soldPrice,
                      priceCalculatedByApp: controller.actualSoldPrice,
                      period: period,
                      toleranceValue: controller.tolerenceValue,
                      status:
                          controller.actualSoldPrice - controller.soldPrice >
                                  controller.tolerenceValue
                              ? SessionStatus.suspicious
                              : SessionStatus.normal,
                      sessionDate: sessionDate,
                    );

                    // Save to database via SessionController
                    Get.find<SessionController>().addSession(session);
                  } else {
                    SnackbarService.show(
                        message: 'Nothing has returned from dialog');
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Save and Close',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>?> showSessionDetailsDialog(
      BuildContext context) async {
    SessionPeriod selectedPeriod = SessionPeriod.morning; // Default value
    DateTime selectedDate = DateTime.now(); // Default to today

    return await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Session Details'),
        content: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dropdown for SessionPeriod
              DropdownButton<SessionPeriod>(
                value: selectedPeriod,
                isExpanded: true,
                items: SessionPeriod.values.map((period) {
                  return DropdownMenuItem<SessionPeriod>(
                    value: period,
                    child: Text(period.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (SessionPeriod? newValue) {
                  setState(() {
                    selectedPeriod = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),
              // Date Picker Button
              ElevatedButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (picked != null && picked != selectedDate) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                ),
                child: Text(
                  'Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cancel
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Return the selected values
              Navigator.pop(context, {
                'period': selectedPeriod,
                'sessionDate': selectedDate,
              });
            },
            child: const Text('Save'),
          ),
        ],
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
            SizedBox(
              width: size.width * .5,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
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
    final isSuspicious = controller.actualSoldPrice - controller.soldPrice >
        controller.tolerenceValue;
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
